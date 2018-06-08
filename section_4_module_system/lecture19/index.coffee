module1 = require "./module-1.coffee"
module1()

module2 = require "./module-2.coffee"
console.log module2

module3 = require "./module-3.coffee"
console.log module3.square()

Square = require "./module-4.coffee"
obj = new Square(10, 10)
console.log obj.area()

cls = require "./module-5.coffee"
obj1 = new cls.Square(10, 10)
console.log obj1.area()
obj2 = new cls.Triangle(10, 10)
console.log obj2.area()


