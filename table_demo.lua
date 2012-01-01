-- A program to read 5 lines from the terminal and to save them in a table

a={};
for i = 1,5 do
	a[i] = io.read();
end
print("Entered text was: ")
for i = 1,#a do
	print(a[i])
end
