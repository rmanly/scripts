import tkinter.filedialog
import xlrd

hostnames = []
from_filename = tkinter.filedialog.askopenfilename(filetypes=[("Excel Files","*.xls")])
to_filename = tkinter.filedialog.asksaveasfilename(defaultextension=".txt", filetypes=(("Text File", "*.txt"),("All Files", "*.*")))

workbook = xlrd.open_workbook(filename=from_filename)
sheet = workbook.sheet_by_index(0)

for cell_contents in sheet.col(4):
    cell_contents = str(cell_contents) 
    if cell_contents.endswith(".org'"):
        hostname = cell_contents.split('.')[0][7:]
        hostnames.append(hostname)

to_file = open(to_filename, 'w')

for hostname in hostnames:
   to_file.write(hostname + '\r')

to_file.close()
