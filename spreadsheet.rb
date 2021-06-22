
require 'google_drive'

def update_cell(wrksht, value, row, col)
  wrksht[row, col] = value
end



# authenticate a session with your service account
session = GoogleDrive::Session.from_service_account_key("client_secret.json")
# # Get the Spreadsheet by its title
spreadsheet = session.spreadsheet_by_title("Stock Test Spreadsheet")
# get the first worksheet
worksheet = spreadsheet.worksheets.first
# print out the first 6 colums of each row

worksheet.rows.each { |row| puts row.first(14).join(" ")}



worksheet

update_cell(worksheet, '=E3/(sum(e3:e:25)', 3, 6)
worksheet.rows.each { |row| puts row.first(14).join(" ")}