<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Know-How Academy</title>
<style>
	.outer>img {
		object-fit: contain;
		display: block;
	}
	.outer>* {
		width: 66%;
		margin: 0 auto;
		text-align: center;
	}
</style>
</head>
<body>
	<jsp:include page="menubar.jsp"/>
	
	<div class="outer">
		<img alt="학원소개이미지" src="/know-how/resources/image/academyintroduce.png" />
		<br><br>
		<h1><b>Khow-How Academy 는 수강생에게 Know-How를 알려주면서 취업의 길로 이끄는 곳입니다.</b></h1>
		<br><br>
		<p>
			<b>
			기존 학원들은 상담 일정을 학원 측에서 일방적으로 정하고 수강생에게 통보하는 방식이 일반적이다. 하지만 이러한 방식은 학생들이 원하는 시간에 충<br><br>
			분한 상담을 받기 어렵고, 진로나 수업, 취업에 대한 고민을 적극적으로 해결하기 힘들다는 한계가 있다.이에 우리 팀은 학생 중심의 상담 환경을 제공하<br><br>
			고자 학원 수강생 및 상담 일정관리 프로그램을 기획하였습니다. 본 프로그램은 학원을 선택하려는 학생이나 현재 학원을 다니고 있는 수강생이 직접 원<br><br>
			하는 날짜와 시간을 선택하여 상담을 신청할 수 있도록 하여, 보다 자유롭고 편리한 상담 문화를 만드는 것을 목표로 한다. 또한 학생들이 학습 방향, 수<br><br>
			업 적응, 취업 준비 등 다양한 고민을 필요할 때마다 부담 없이 상담받을 수 있도록 지원함으로써, 학원과 학생 간의 소통을 강화하고 학습 만족도를 높이<br><br>
			고자 합니다. 이를 통해 기존 학원들과 차별화된 학생 맞춤형 상담 서비스를 제공하는 것이 본 프로젝트의 핵심 기획 의도입니다.
			</b>
		</p>
	</div>
	
	<jsp:include page="footer.jsp" />
</body>
</html>