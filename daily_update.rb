require 'google_drive'


session = GoogleDrive::Session.from_service_account_key("client_secret.json")
spreadsheet = session.spreadsheet_by_title("Stock Test Spreadsheet")
worksheet_one = spreadsheet.worksheets.first
worksheet_two = spreadsheet.worksheets[1]

date = Time.new.strftime("%m-%d-%Y")

worksheet_one.export_as_file( "#{date}.csv")

def make_dir(dir_name)
  unless Dir.exist?(dir_name)
    Dir.mkdir(dir_name)
  end
end

make_dir("snapshot")
File.rename("#{date}.csv", "snapshot/#{date}.csv")

def sum(worksht, rtrn = nil , crypto_sum = [], stock_sum = [])
  worksht.rows.each do |row|
    if row[1] == "CRYPTO"
      crypto_sum << row[4] 
    else
      stock_sum << row[4]
    end
  end
  arr = rtrn == 'crypto' ? crypto_sum : stock_sum
  arr = format_arr(arr)
  arr.sum
end

def format_arr(arr)
  arr.map do |val|
    val.gsub!(/\$|\,/, '')
    val.to_f
  end
end

# sum up the crypto total and the stock total and print to second sheet of google doc.

crypto_total = sum(worksheet_one, "crypto")
stock_total = sum(worksheet_one)

worksheet_two.insert_rows(worksheet_two.num_rows + 1, [["#{date}", "#{stock_total}", "#{crypto_total}", "#{stock_total + crypto_total}"]])
worksheet_two.save

# Limit the Number of daily snapshots to 10 to save storage

def limit_dir_size(dir_name, num)
  files = Dir.glob("#{dir_name}/*")
  if files.length > num
    File.delete(files[0])
  end
end

limit_dir_size('snapshot', 10)