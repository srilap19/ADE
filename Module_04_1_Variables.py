# Databricks notebook source
# MAGIC %md
# MAGIC -                                                                              `Module-5`

# COMMAND ----------

# MAGIC %md
# MAGIC #### Question 1- Creating Python Variables

# COMMAND ----------

# MAGIC %md
# MAGIC #### A variable is a container for storing data values. It's like a label that you can use to refer to a value in your program. You can assign any type of data to a variable (e.g., numbers, text, lists) without declaring its type.
# MAGIC
# MAGIC * **Assigning values to variables**
# MAGIC * name = "Alice"          # String
# MAGIC * age = 25                # Integer
# MAGIC * height = 5.6            # Float
# MAGIC * is_student = True       # Boolean
# MAGIC
# MAGIC * **Dynamic Typing:** You don’t need to specify the type of the variable (Python figures it out)
# MAGIC
# MAGIC * x = 10        # x is an integer
# MAGIC * x = "hello"   # Now x is a string

# COMMAND ----------

# MAGIC %md
# MAGIC #### Question 2- Getting Type of a Variable

# COMMAND ----------

x = "Zara"
y =  10
z =  10.10

print( "x =", x )
print( "y =", y )
print( "z =", z )
print(type(x))
print(type(y))
print(type(z))


# COMMAND ----------

# MAGIC %md
# MAGIC #### Question 3- Casting Python Variables

# COMMAND ----------

#You can specify the data type of a variable with the help of casting as follows:
x = str(10)    # x will be '10'
y = int(10)    # y will be 10 
z = float(10)  # z will be 10.0


# COMMAND ----------

# MAGIC %md
# MAGIC #### Question 4- Case-Sensitivity of Python Variables

# COMMAND ----------

#Python variables are case sensitive which means Age and age are two different variables
age = 20
Age = 30

print( "age =", age )
print( "Age =", Age )


# COMMAND ----------

# MAGIC %md
# MAGIC #### Question 5- Python Variables - Multiple Assignment

# COMMAND ----------

a=b=c=10
print (a,b,c)

a,b,c = 10,20,30
print (a,b,c)


# COMMAND ----------

# MAGIC %md
# MAGIC #### Question 6- Deleting Python Variables

# COMMAND ----------

var=10
print(var)
del var
print(var)

# COMMAND ----------

# MAGIC %md
# MAGIC #### 4.6-DataTypes

# COMMAND ----------

# MAGIC %md
# MAGIC * Numeric - int, float, complex
# MAGIC * Sequence Type - string, list, tuple
# MAGIC * Mapping Type - dict
# MAGIC * Boolean - bool
# MAGIC * Set Type - set, frozenset
# MAGIC * Binary Types - bytes, bytearray, memoryview

# COMMAND ----------

Example				Data Type	
x = "Hello World"			        str	
x = 20					            int	
x = 20.5					        float	
x = 1j					            complex	
x = ["apple", "banana", "cherry"]	list	
x = ("apple", "banana", "cherry")	tuple	
x = range(6)				        range	
x = {"name" : "John", "age" : 36}	dict	
x = {"apple", "banana", "cherry"}	set	
x = True					        bool	


# COMMAND ----------

# MAGIC %md
# MAGIC #####Summary of Methods Used:
# MAGIC * len(): Returns the length of the string.
# MAGIC * upper(): Converts all characters in the string to uppercase.
# MAGIC * lower(): Converts all characters in the string to lowercase.
# MAGIC * capitalize(): Capitalizes the first character of the string.
# MAGIC * title(): Capitalizes the first character of each word in the string.

# COMMAND ----------

# MAGIC %md
# MAGIC #####  Print the length of the string:

# COMMAND ----------

str1 = 'Python programming'
print("Length of the string:", len(str1))

# COMMAND ----------

# MAGIC %md
# MAGIC ##### - Print the string in uppercase:

# COMMAND ----------

str1 = 'Python programming'
print("String in uppercase:", str1.upper())

# COMMAND ----------

# MAGIC %md
# MAGIC ##### - Print the string in lowercase:

# COMMAND ----------

str1 = 'Python programming'
print("String in lowercase:", str1.lower())

# COMMAND ----------

# MAGIC %md
# MAGIC ##### - Print the string with the first letter in capital:

# COMMAND ----------

str1 = 'Python programming'
print("String with first letter in capital:", str1.capitalize())

# COMMAND ----------

# MAGIC %md
# MAGIC ##### 1.1 Print the string with all letters in capital:

# COMMAND ----------

str1 = 'Python programming'
print("String with all letters in capital:", str1.title())

# COMMAND ----------

# MAGIC %md
# MAGIC #####Summary of Methods Used:
# MAGIC * len(): Returns the length of the string.
# MAGIC * upper(): Converts all characters in the string to uppercase.
# MAGIC * lower(): Converts all characters in the string to lowercase.
# MAGIC * capitalize(): Capitalizes the first character of the string.
# MAGIC * title(): Capitalizes the first character of each word in the string.

# COMMAND ----------

# MAGIC %md
# MAGIC ##### -Print the result of addition, subtraction, multiplication, division, and modulus operations using these variables.

# COMMAND ----------

a = 15
b = 4

# Addition
addition = a + b
print("Addition:", addition)

# Subtraction
subtraction = a - b
print("Subtraction:", subtraction)

# Multiplication
multiplication = a * b
print("Multiplication:", multiplication)

# Division
division = a / b
print("Division:", division)

# Modulus (remainder)
modulus = a % b
print("Modulus:", modulus)
