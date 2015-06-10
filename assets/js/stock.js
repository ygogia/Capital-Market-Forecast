var stocks = [
	{name:"AAPL",img:""},
	{name:"BAC",img:""},
	{name:"TWTR",img:""},
	{name:"YHOO",img:""},
	{name:"FB",img:""},
	{name:"GOOGL",img:""},
	{name:"NFLX",img:""},
	{name:"GDDY",img:""},
	{name:"TTM",img:""},
	{name:"RS",img:""},
]
function updateStock(i){
   var number = Math.floor((Math.random() * 10) + 1)-1;
   
   $.ajax({
      url: "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20('"+ stocks[number].name +"')&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=",
      data: {
         format: 'json'
      },
      error: function() {
         $('#info').html('<p>An error has occurred</p>');
      },
      dataType: 'json',
      success: function(data) {
		var name=data.query.results.quote.Name;
		var ticker=data.query.results.quote.Symbol;
		var price= data.query.results.quote.LastTradePriceOnly;
		var change= data.query.results.quote.Change;
		var changepercent= data.query.results.quote.ChangeinPercent;
		if(change.substr(0,1)=='-')
			var frmt="$" + price + "<b class='down-stock'> " +  change.substr(1,change.length) + "(" + changepercent.substr(1,changepercent.length) + ")</b><img src='assets/images/down_r.gif' class='stock-indicate'>";
		else
			var frmt="$" + price + "<b class='up-stock'> " +  change + "(" + changepercent + ")</b><img src='assets/images/up.png' class='stock-indicate' width='11px'>";
		document.getElementById("stock"+i).innerHTML=frmt;
		document.getElementById("stockName"+i).innerHTML="<img src='assets/images/stocks/"+stocks[number].name+".jpg' style='float:right;width:30px;'>"+name + "(" + ticker + ")";
		},
      type: 'GET'
   });
}