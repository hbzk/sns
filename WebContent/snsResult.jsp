<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String urlParam = request.getParameter("p");

try {
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(
		"jdbc:mysql://localhost:3306/semidb", "semi", "semi");
	// 게시물의 총 수를 얻는 쿼리 실행
	
	pstmt = conn.prepareStatement("SELECT * FROM SNS_LOGS WHERE URL_PARAM=?");
	pstmt.setString(1, urlParam);
	rs = pstmt.executeQuery();
	
	rs.next();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="format-detection" content="telephone=no" />
<meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width, height=device-height, target-densitydpi=medium-dpi" />
<meta name="title" content="semiLog" />
<meta name="description" content="My Log" />
<link rel="image_src" href="img/semiLog_logo.png" />
<link rel="icon" type="image/x-icon" href="img/semiLog_logo.png" />
<link rel="stylesheet" href="font/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="css/lineconStyle.css">
<link rel="stylesheet" href="css/common_font.css">
<link rel="stylesheet" href="css/result.css">

<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="js/jquery.touchSwipe.js"></script>
<script type="text/javascript" src="js/jquery.drawDoughnutChart.js"></script>
<script type="text/javascript" src="js/result.js"></script>
<title>semiLog ; My Log</title>

<style type="text/css">
.header>img { position:absolute; top:10px; left:10px; height: 40px; /* width: 40px;  */}

#google_play { text-align: center; }
#google_play>p { font-family: 'orbitron', sans-serif; margin-top: 40px; }
#google_play>img { height: 45px; margin: 10px 0 30px; margin-left: 5px;}
</style>

</head>
<body>



<div class="header" data-role="header">
	<!-- <img src="img/semiLog_logo.png"> -->
	<p>LOG Result</p>
</div>
<div id="date">
	<p id="period"></p>
</div>
<section id="layout">
	<div id="chart"></div>
</section>

<div id="google_play">
	<p>Download semiLog</p>
	<img src="img/semiLog_logo.png"><img src="img/google_play.png">
</div>
</body>
<script type="text/javascript">


var scope = '<%=rs.getString("SCOPE") %>';
var period = '<%=rs.getString("PERIOD") %>';

$('#period').text(period);

if (scope == 'WEEK') $('#period').css('font-size', '150%');
else $('#period').css('font-size', '200%');

var result = [];
var tempObj = new Object();
tempObj['title'] = '<%=rs.getString("TITLE") %>';
tempObj['color'] = '<%=rs.getString("COLOR") %>';
tempObj['value'] = <%=rs.getString("VAL") %>;
result.push(tempObj);

			<%
			while(rs.next()) {
			%>
tempObj = new Object();
tempObj['title'] = '<%=rs.getString("TITLE") %>';
tempObj['color'] = '<%=rs.getString("COLOR") %>';
tempObj['value'] = <%=rs.getString("VAL") %>;
result.push(tempObj);
			<%
			}
			%>

</script>

</html>
<%
} catch (Exception e) {
	e.printStackTrace();
} finally {
	if (rs != null) rs.close();
	if (pstmt != null) pstmt.close();
	if (conn != null) conn.close();
}
%>