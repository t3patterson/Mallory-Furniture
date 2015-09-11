#Mallory Furniture

###Description
Mallory Furniture is a local vintage furniture retailer with a constantly changing selection. Their showroom has limited floor space so they initially built a site to show all their inventory, including those in the warehoue.

They decided not to go the e-commerce route so they only need static pages to show what product they currently have. Regardless, they've found maintaining the site to be to be a pain in the ass since they can't easily synchronize the items on the page with the continuously changing items in stock.

They've kept good records in an Excel spreadsheet and they are wondering if there is an easier way to keep their site up to date as their inventory changes.

###Requirements
**Make a Rails app that generates static pages of their current inventory based on data imported from a `.csv` file.**

####Normal Mode
There should be 3 types of pages: the home page, a page that shows multiple-products, and a single-product page. Your Rails app should handle the routing, controller logic, and view rendering based on how the user navigates the site.

In the controller, some data manipulation is required.

1. Create a `FurnitureItem` class for each item.
2. Create a method that identifies items on clearance and adjusts the price.
  - Apply a 10% discount on the price for items that are in 'good' condition
  - Apply a 20% discount on the price for items that are in 'average' condition.
  - For each clearance item on the page, make sure that the site indicates that the item is on clearance (next to the price, for instance).
3. Do not show items on the site that have a quantity of 0.


####Hard Mode
1. Organize the items by furniture category on the multiple-products page.
2. On the home page, show the furniture-categories as options that the user can select. When they navigate from the home-page to the multiple-products page after selecting an option, they will only see items of the category they selected.
  - *e.g. if they select 'tables' then they will only see the items that are in the 'tables' category*

####Nightmare mode.
Instead of using a warehouse, Mallory Furniture is expanding their display area by putting their inventory into 3 retail locations: North, South, and West. 

Items with PID's between 100-199 will go to the North location, items with PID's 200-299 will go to the South location and items with PID's 300 and up will go to the West location.

1. Identify the location of each item and create a route and view for each location.
2. On the single-listing page, show same-category items that are at the same location. 
  - *e.g. "additional {category} at this location: {item1} {item2} {item3}".*
  