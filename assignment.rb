require 'csv'
#table = CSV.parse(File.read("/home/sharath/sharath3.csv"), headers: true)

@path
class Product 
attr_accessor :id, :name,:price
    def initialize(id, name, price)
        @id = id
        @name = name
        @price = price
    end


end

def insert(id, name, price)
   product =   Product.new(id,name,price)
   CSV.open(@path, "a+") do |csv|
      csv << [product.id, product.name,product.price]
    end   
end
#to insert the product inside the csv file




def save_exit
  puts "enter the path of excel file"
      file_path =gets.chomp
      @path = file_path  # taking the previous timestamp from the terminal please enter the proper file name
  time = (Time.now.to_f * 1000).to_i
  filename = time.to_s + ".csv"
  from_file = @path
  new_file = filename
  File.rename(from_file, new_file)
end
#it will save the file with current timestap and exit 
def product_search
  puts "please select one option to search by the product"
  puts "1 id\n 2 name\n 3 price"
  row_array = CSV.read(@path)
  option = gets.chomp
  @product = nil
  case option
  when "1"
    puts "Please enter the product id"
    id = gets.chomp
     row_array.each { |row|
                if row[0] == id
                  @product = row
                end
              }
          
     p    @product.nil? ? "product not found with id #{id}" : @product
  when "2"
    puts "please enter the product name"
    name = gets.chomp
    new_array = row_array.each { |row|
                if row[1] == name
                  @product = row
                end
                }
    p    @product.nil? ? "product not found with name #{name}" : @product
            
  when "3"
    puts "please enter the product price"
    price = gets.chomp
    new_array = row_array.each { |row|
                if row[2] == price
                  @product = row
                end
                }
    p    @product.nil? ? "product not found with price #{price}" : @product
  end
end


def delete_product(product_id)
  row_array = CSV.read(@path)
  new_array = row_array.delete_if { |row| row[0] ==product_id} # based on the product id we can delete the product
  p new_array
  CSV.open(path,"w+") { |csv| row_array.each{|row| csv << row}}
end
    
def update_product(product_id)
  row_array = CSV.read(@path)
  new_array = row_array.each { |row|
              if row[0] == product_id
                p "enter the name"
                name = gets.chomp
                row[1] = name.to_s
                p "enter the price"
                price = gets.chomp
                row[2] = price.to_s
              end
          }
  p new_array
  CSV.open(@path,"w+") { |csv| row_array.each{|row| csv << row}}    
end

status = true
while status 
    puts "Please enter the following options \n"
    puts "1 Insert\n 2 Delete\n 3 Update\n 4 product_search \n 5 save&exit  \n 6 insertcsv \n 7 createcsv"
    option = gets.chomp
    case option
    when "1"
      
        puts "please enter the id of the product"
        id = gets.chomp
        puts "please enter the name of the product"
        name =gets.chomp
        puts "please enter the price of the product"
        price = gets.chomp
        insert(id,name,price)
    when "2"
      puts "please enter the id of the product to be deleted"
      id = gets.chomp
      delete_product(id) 
    when "3"
        puts "please enter the id of the product "
        id = gets.chomp 
        update_product(id)

    when "4"
      product_search
    when "5"
      save_exit

       status = false
    when "6"
      #since the filename keeps update this option is given to enter the filename from terminal eg /home/sharath/testdata.csv
      puts "enter the path of excel file"
      file_path =gets.chomp
      @path = file_path
    when "7"
      if @path == nil
        @path = "testdata.csv"
        #w+ will create a new file called testdata.csv 
      CSV.open(@path, "w+") do |csv|
        csv << ["id", "name","price"]
      end
    end   
    end

end 