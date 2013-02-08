<?php
set_time_limit(0);
$fp = fopen (dirname(__FILE__) . '/localfile.xml', 'w+');//This is the file where we save the    information
$ch = curl_init(str_replace(" ","%20","https://www.odesk.com/jobs/rss?q=mobile"));//Here is the file we are downloading, replace spaces with %20
curl_setopt($ch, CURLOPT_TIMEOUT, 50);
curl_setopt($ch, CURLOPT_FILE, $fp); // here it sais to curl to just save it
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
$data = curl_exec($ch);//get curl response
curl_close($ch);
fwrite($fp, $data);//write curl response to file
fclose($fp);
?>

