<html>
<head>
	<title>R Graphs</title>
	<style>
		.plot{
			border:1px solid #cacaca;
			width:400px;
		}
	</style>
</head>
<body>
	<div id='graphs'>
		<?php
		    include('config.php'); 
	
           	$ticker = $_REQUEST['ticker'];
			
			$a1='del '.$xampp_dir_path.'\TimeSlice.png';
			$a2='del '.$xampp_dir_path.'\Trends.png';
			$a3='del '.$xampp_dir_path.'\MovingAverage.png';
			$a4='del '.$xampp_dir_path.'\ExpMovAvg.png';
	
			$r_dir_path = '"'.$r_dir_path.'\Rscript.exe"';
			$xampp_dir_path = '"'.$xampp_dir_path.'\Trends.r"';
			$main = $r_dir_path." ".$xampp_dir_path;
		     
		    echo $ticker;
			
			//Deleting Previous Session Files
			exec($a1, $out, $ret);
			exec($a2, $out, $ret);
			exec($a3, $out, $ret);
			exec($a4, $out, $ret);
			
			//Downloading Data From Yahoo 
			$url = "http://ichart.finance.yahoo.com/table.csv?d=6&e=1&f=2015&g=d&a=7&b=19&c=2001%20&ignore=.csv&s=".$ticker;
			
			//Copying to file on Server
			copy($url, 'table.csv');
			
			//Executing R Script
			// exec('"C:\Program Files\R\R-3.2.0\bin\Rscript.exe" "C:\xampp\htdocs\Testing\Trends.r"', $output, $return);
			exec($main, $output, $return);
			//Showing Output Images
					echo "<h2>Time Sliced Stock Data</h2><img src='TimeSlice.png' class='plot'>";
					echo "<h2>Trends in Stock Data</h2><img src='Trends.png' class='plot'><br>";
					echo "<h2>Moving Average</h2><img src='MovingAverage.png' class='plot'>";
					echo "<h2>Exponential Moving Average</h2><img src='ExpMovAvg.png' class='plot'>";
					
					echo "<br>";
		?>
	</div>
</body>

