<?php
$port = '9000';
header('Location: '
    . ($_SERVER['HTTPS'] ? 'https' : 'http')
    . '://' . $_SERVER['HTTP_HOST'] . ':' . $port);
exit;
?>