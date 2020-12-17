---
layout: post
title: Imperative, Declarative, Functional, Reactive
date: 2020-12-16 19:16 -0800
---


# Imperative (Standard C, Java, etc)
```
var income_m = 0, income_f = 0;
for (var i = 0; i < income_list.length; i++) {
    if (income_list[i].gender == 'M')
        income_m += income_list[i].income;
    else
        income_f += income_list[i].income;
}
```
* explicit initialization of variables that will contain the running totals
* explicit loop over the data, modifying the control variable (i) and the running totals at each iteration
* conditionals (ifs) are only used to choose the code path at each iteration


# Declarative (SQL, XSLT)
```
select gender, sum(income)
from income_list
group by gender;
```
* memory cells to contain running totals are implied by the output you declare you want;
* any loop the CPU will need to perform (eg. over the income_list table) is implied by the output you declare you want and by the structure of the source data;
* conditionals (eg. case in SQL) are used in a functional way to specify the output value you want based on the input values, not to choose a code path.


# Functional (Swift, Javascript, Python, R, Haskell, Groovy)

Imperative Version
```
function getOdds(arr){
   let odds = [ ];
    for(let i = 0; i < arr.length + 1; i++){
          if ( i % 2 !== 0 ){
             odds.push( i )
          };
        };
    return odds
  };
```

Functional Version
```
const onlyOdds = [1,2,3,4,5,6] => arr.filter({$0 % 2 == 1})
```

Even Better Functional Version
```
extension Array where Element == Int {
    func getOdds() -> [Int] {
        return self.filter({$0 % 2 == 1})
    }
}

[1,2,3,4,5].getOdds()
```

* Stylistically, we define a problem and the changes we would like to see, as opposed to explaining it step by step.
* We do not need to manage state in our functions like above where we managed the state of our empty array.
* We don not have to worry as much about the order of execution.
* We use less loops, conditions and use more built in methods, reusable functions and recursion.


# Reactive
```
manager.getCampaignById(id)
  .flatMap(campaign ->
    manager.getCartsForCampaign(campaign)
      .flatMap(list -> {
        Single<List<Product>> products = manager.getProducts(campaign);
        Single<List<UserCommand>> carts = manager.getCarts(campaign);
        return products.zipWith(carts, 
            (p, c) -> new CampaignModel(campaign, p, c));
      })
     .flatMap(model -> template
        .rxRender(rc, "templates/fruits/campaign.thl.html")
        .map(Buffer::toString))
    )
    .subscribe(
      content -> rc.response().end(content),
     err -> {
      log.error("Unable to render campaign view", err);
      getAllCampaigns(rc);
    }
);
```

Note - Rx means "reactive extension" and the initialism has come to imply 