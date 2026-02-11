# Databricks notebook source
# MAGIC %md
# MAGIC -                                                                              `Module-5`

# COMMAND ----------

# MAGIC %md
# MAGIC ##### Python Collections (Arrays)
# MAGIC * There are four collection data types in the Python programming language:
# MAGIC
# MAGIC * List is a collection which is ordered and changeable. Allows duplicate members. []
# MAGIC * Tuple is a collection which is ordered and unchangeable. Allows duplicate members. ()
# MAGIC * Set is a collection which is unordered and unindexed. No duplicate members. {}
# MAGIC * Dictionary is a collection which is unordered, changeable and indexed. No duplicate members. {}

# COMMAND ----------

# MAGIC %md
# MAGIC #### List

# COMMAND ----------

fruits = ['Apple', 'Banana', 'Mango', 'Pineapple', 'Grapes']

# COMMAND ----------

# MAGIC %md
# MAGIC ####  1. append(): Add an element at the end

# COMMAND ----------

fruits.append('Orange')
print("After append:", fruits)

# COMMAND ----------

# MAGIC %md
# MAGIC ##### 2. pop(): Remove and return the last element (or element at given index)

# COMMAND ----------


popped_item = fruits.pop()  # Removes 'Orange'
print("After pop:", fruits)
print("Popped item:", popped_item)

# COMMAND ----------

# MAGIC %md
# MAGIC #### 3.insert(): Insert an item at a specific index

# COMMAND ----------

fruits.insert(2, 'Strawberry')  # At index 2
print("After insert:",fruits)

# COMMAND ----------

# MAGIC %md
# MAGIC #### 4. remove(): Remove the first occurrence of a value

# COMMAND ----------

fruits.remove('Banana')
print("After remove:",fruits)

# COMMAND ----------

# MAGIC %md
# MAGIC #### 5. sort(): Sort the list in ascending order

# COMMAND ----------

fruits.sort()
print("After sort:", fruits)

# COMMAND ----------

# MAGIC %md
# MAGIC #### 6. reverse(): Reverse the current order of the list

# COMMAND ----------

fruits.reverse()
print("After reverse:",fruits)

# COMMAND ----------

# MAGIC %md
# MAGIC #### 7. clear(): Remove all elements from the list

# COMMAND ----------

fruits.clear()
print("After clear:", fruits)

# COMMAND ----------

#### 8. extend(): Add multiple elements to the list

# COMMAND ----------

fruits.extend(['Kiwi', 'Papaya', 'Guava'])
print("After extend:",fruits)

# COMMAND ----------

# MAGIC %md
# MAGIC #### Indexing

# COMMAND ----------

# MAGIC %md
# MAGIC #### Positive Indexing:
# MAGIC #### Use square brackets [] to access elements.

# COMMAND ----------

    my_list = [10, 20, 30, 40, 50]
    print(my_list[0])  # Output: 10 (first element)
    print(my_list[2])  # Output: 30 (third element)

# COMMAND ----------

# MAGIC %md
# MAGIC #### Negative Indexing:
# MAGIC #### Negative indices count from the end of the sequence. -1 refers to the last element, -2 to the second-to-last, and so on.

# COMMAND ----------

    my_list = [10, 20, 30, 40, 50]
    print(my_list[-1])  # Output: 50 (last element)
    print(my_list[-3])  # Output: 30 (third from last)

# COMMAND ----------

# MAGIC %md
# MAGIC ##### 46- Print the first and last item in the list.
# MAGIC

# COMMAND ----------

favorite_fruits = ['Apple', 'Banana', 'Mango', 'Pineapple', 'Grapes']

# Print the first and last item
print("First item:", favorite_fruits[0])
print("Last item:", favorite_fruits[-1])

# COMMAND ----------

print(favorite_fruits[0], favorite_fruits[-1])

# COMMAND ----------

# MAGIC %md
# MAGIC ##### Q 49- Print the list in reverse order.
# MAGIC

# COMMAND ----------

favorite_fruits = ['Apple', 'Banana', 'Mango', 'Pineapple', 'Grapes']

# Print the list in reverse order
print("List in reverse order:", favorite_fruits[::-1])


# COMMAND ----------

# MAGIC %md
# MAGIC #### Slicing
# MAGIC #### Slicing allows us to extract a part of the string. We can specify a start index, end index, and step size. The general format for slicing is:
# MAGIC #### string[start : end : step]
# MAGIC * start : We provide the starting index.
# MAGIC * end : We provide the end index(this is not included in substring).
# MAGIC * step : It is an optional argument that determines the increment between each index for slicing.
# MAGIC

# COMMAND ----------

    my_list = [10, 20, 30, 40, 50]
    print(my_list[1:4:2])  # Output: [20, 30, 40] (elements at indices 1, 2, 3)
    print(my_list[2:])  # Output: [30, 40, 50] (elements from index 2 to the end)
    print(my_list[:3])  # Output: [10, 20, 30] (elements from beginning up to index 3)
    print(my_list[:])  # Output: [10, 20, 30, 40, 50] (entire list)

# COMMAND ----------

# MAGIC %md
# MAGIC #### 2. tuple
# MAGIC
# MAGIC * Tuple is a collection which is ordered and unchangeable. Allows duplicate members. ()

# COMMAND ----------

my_tuple = (10, 20, 30, 20)
my_tuple.count(20)

# COMMAND ----------

my_tuple.index(30)

# COMMAND ----------

# DBTITLE 1,add element into tuple
# tuple convert into list
fruits_tup = ('Apple', 'Banana', 'Mango', 'Pineapple')

# Convert tuple to list
fruits_list = list(fruits_tup)

# Add new element
fruits_list.append('Grapes')

# Convert list back to tuple
fruits_tup = tuple(fruits_list)

print(fruits_tup)


# COMMAND ----------

# MAGIC %md
# MAGIC #### 3. Set
# MAGIC * A set is a collection which is unordered and unindexed. In Python, sets are written with curly brackets.

# COMMAND ----------

object = {1,2,1,1,1,2,2,2,2,4,5,5,5,'gaurav',5,6,'monu',6,6,6,7,7,7}
print(object)

# COMMAND ----------

set1 = {1, 2, 4, 5, 'Ram', 6, 'Shyam', 7}

# COMMAND ----------

# MAGIC %md
# MAGIC #### 1. add() – Add a single element to the set

# COMMAND ----------

set1.add('Ravi')
print("After add:", set1)

# COMMAND ----------

# MAGIC %md
# MAGIC #### 2. remove() – Remove a specific element; raises KeyError if not found

# COMMAND ----------

set1.remove('Ram')
print("After remove:", set1)

# COMMAND ----------

# MAGIC %md
# MAGIC #### 3. discard() – Remove a specific element; does not raise an error if not found

# COMMAND ----------

set1.discard('Shyam')
set1.discard('NotExist')  # No error
print("After discard:", set1)

# COMMAND ----------

# MAGIC %md
# MAGIC #### 4. pop() – Remove and return a random element (since sets are unordered)

# COMMAND ----------

popped_item = set1.pop()
print("After pop:", set1)
print("Popped item:", popped_item)

# COMMAND ----------

# MAGIC %md
# MAGIC ####  5. clear() – Remove all elements

# COMMAND ----------

set1.clear()
print("After clear:", set1)  # Output: set()

# COMMAND ----------

# MAGIC %md
# MAGIC #### 6.union() – Combines both sets (removes duplicates)

# COMMAND ----------

set1 = {1, 2, 3, 4, 5}
set2 = {4, 5, 6, 7, 8}

union_set = set1.union(set2)
print("Union:", union_set)
# Output: {1, 2, 3, 4, 5, 6, 7, 8}


# COMMAND ----------

# MAGIC %md
# MAGIC #### 7. intersection() – Common elements between both sets

# COMMAND ----------

intersection_set = set1.intersection(set2)
print("Intersection:", intersection_set)
# Output: {4, 5}

# COMMAND ----------

# MAGIC %md
# MAGIC #### 8. difference() – Elements in set1 but not in set2

# COMMAND ----------

difference_set = set1.difference(set2)
print("Difference (set1 - set2):", difference_set)
# Output: {1, 2, 3}

# COMMAND ----------

# MAGIC %md
# MAGIC #### 4. Dictionary

# COMMAND ----------

# MAGIC %md
# MAGIC * A dictionary is a collection which is unordered, changeable and indexed. In Python dictionaries are written with curly brackets, and they have keys and values.
# MAGIC * dict = {"key1":"value1","key2":"value2",}
# MAGIC * dict

# COMMAND ----------

# Create a dictionary with keys and their respective prices as values
fruit_prices = {
    "apple": 50,
    "banana": 20,
    "cherry": 100
}

# COMMAND ----------

# MAGIC %md
# MAGIC #### 1. get() – Get the value for a key (returns None if key not found)

# COMMAND ----------

print("Price of apple:", fruit_prices.get("apple"))     # Output: 50
print("Price of mango:", fruit_prices.get("mango"))     # Output: None
print("Price of mango with default:", fruit_prices.get("mango", 0))  # Output: 0

# COMMAND ----------

# MAGIC %md
# MAGIC #### 2. keys() – Return all keys

# COMMAND ----------

print("Keys:", fruit_prices.keys())
# Output: dict_keys(['apple', 'banana', 'cherry'])

# COMMAND ----------

# MAGIC %md
# MAGIC #### 3. values() – Return all values

# COMMAND ----------

print("Values:", fruit_prices.values())
# Output: dict_values([50, 20, 100])

# COMMAND ----------

# MAGIC %md
# MAGIC ####  4. items() – Return all key-value pairs

# COMMAND ----------

print("Items:", fruit_prices.items())
# Output: dict_items([('apple', 50), ('banana', 20), ('cherry', 100)])

# COMMAND ----------

# MAGIC %md
# MAGIC #### 5. pop() – Remove a key and return its value

# COMMAND ----------

price = fruit_prices.pop("banana")
print("After pop:", fruit_prices)
print("Popped value:", price)
# Output: {'apple': 50, 'cherry': 100}

# COMMAND ----------

# MAGIC %md
# MAGIC #### 6. update() – Update existing key or add a new one

# COMMAND ----------

fruit_prices.update({"apple": 60, "mango": 70})
print("After update:", fruit_prices)
# Output: {'apple': 60, 'cherry': 100, 'mango': 70}

# COMMAND ----------

# MAGIC %md
# MAGIC #### 7. clear() – Remove all items

# COMMAND ----------

fruit_prices.clear()
print("After clear:", fruit_prices)
# Output: {}
