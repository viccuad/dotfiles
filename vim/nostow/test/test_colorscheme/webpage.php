<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="pt-br">
   <head>
      <title>EXAMPLE</title>
   </head>
<body>
<h1>About you...</h1>
<?php 
   if(strstr(strtolower($_SERVER['HTTP_USER_AGENT']), "windows")){
      print("Why are you using Windows?");
   } else {
      print("Are you using Linux?");
   }
?>
<p>For more info, click
<a href="http://localhost">here</a>.</p>

</body>
</html>
