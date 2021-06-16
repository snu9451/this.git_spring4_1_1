<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript">
		const d = new Array();
		d[0] = 30;
		d[1] = "따릉이";
		d[2] = true;
		const d2 = new Array(50,"노트북", false);
		const d3 = [70,"핸드폰", true];
		for(let a =0; a < 3; a++){
			document.write(d[a]);
			document.write(d2[a]);
			document.write(d3[a]);
			document.write("<br>");
		}
// 		document.write(d);
		document.write(d2);
		document.write(d3);
	</script>
</body>
</html>