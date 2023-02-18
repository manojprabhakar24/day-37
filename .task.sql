1.Find all the information about each products

db.Product.find({})

2.Find the product price which are between 400 to 800

db.Product.find({product_price:{$gte:400 ,$lte:800 }});

3.Find the product price which are not between 400 to 600

db.Product.find({$or: [{product_price:{$gte:600}},{product_price:{$lte: 400}}]});

4.List the four product which are grater than 500 in price 

db.Product.find({product_price:{$gte:500}});

5.Find the product name and product material of each products

db.Product.find({},{product_name:1 , product_material:1,_id:0});

6.Find the product with a row id of 10

db.Product.find({id:"10"});

7.Find only the product name and product material

db.Product.find({},{_id:0,id:0,product_price:0 ,product_color:0});

8.Find all products which contain the value of soft in product material 

db.Product.find({product_material:"Soft"});

9.Find products which contain product color indigo  and product price 492.00

db.Product.find({$and:[{product_color:"indigo"},{product_price:"492.00"}]});

10.Delete the products which product price value are same


var duplicates = [];

db.Product.aggregate([
 
  { $group: { 
    _id: { product_price: "$product_price"}, 
    dups: { "$addToSet": "$_id" }, 
    count: { "$sum": 1 } 
  }},
  { $match: { 
    count: { "$gt": 1 }   
  }}
],
{allowDiskUse: true}       
)               
.forEach(function(doc) {
    doc.dups.shift();   
    doc.dups.forEach( function(dupId){ 
        duplicates.push(dupId);  
        }
    )
})

printjson(duplicates);     

db.Product.remove({_id:{$in:duplicates}}) 