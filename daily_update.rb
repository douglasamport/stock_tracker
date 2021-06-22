require 'google_drive'


session = GoogleDrive::Session.from_service_account_key("client_secret.json")
spreadsheet = session.spreadsheet_by_title("Stock Test Spreadsheet")
worksheet_one = spreadsheet.worksheets.first
worksheet_two = spreadsheet.worksheets[1]


date = Time.new.strftime("%m-%d-%Y")


worksheet_one.export_as_file( "#{date}.csv")

# move file into directory
#check number of files in directory & remove old ones after 10 or so

def make_dir
 unless Dir.exist?
  Dir.mkdir(snapshot)
  
end

# Summarize total of stocks and total of crypto 
# assign to correct columns of Worksheet Two.

stock_total = 
crypto_total = 