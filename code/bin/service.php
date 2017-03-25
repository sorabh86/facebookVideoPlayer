<?php
	$id = isset($_REQUEST['id'])?$_REQUEST['id']:"";
	$pass = isset($_POST['pass'])?$_REQUEST['pass']:"";
	$path = "hello world";
	if($pass == 'pass') {
		switch($id) {
			case 1: $path = "<img>media/basketball.jpg</img>
							<video>media/basketball.f4v</video>";
				break;
			case 2: $path = "<img>media/video01.jpg</img>
							<video>media/video01.mp4</video>";
				break;
			case 3: $path = "<img>media/video02.jpg</img>
							<video>media/video02.mp4</video>";
				break;
		}
	}
	echo base64_encode("<xml>$path</xml>");
?>