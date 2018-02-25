<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/room.css" />
<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet">
</head>
<body>

    <div class="container">
        
            <header>
               <h1><a href="main.html">펠리치타 로마</a></h1>
            </header>

            <div class="nav">
               <ul class="menu">
                    <li class="grid1"><a href="introduce">펠리치타로마 소개</a></li>
                     <li class="grid2"><a onclick="location.href='list'" style="cursor:pointer">예약안내</a></li>
                     <li class="grid3"><a href="room">객실정보</a></li>
                    <li class="grid4"><a href="way">찾아오시는길</a></li>
                </ul>
                
            </div>
       
        
        <section class="slider clearfix" >
            <div class="typho">Room & PRICE </div>
            <ul class="item clearfix">
                <li class="img1"><img id="my_image" src="images/room_main.jpg"/></li>
                <li class="img2"><img id="my_image2" src="images/bedroom.PNG"/></li>
            </ul>  
        </section>
        
       

		 <table cellpadding="0" cellspacing="0" class="tb_data">
             <tbody>
			<colgroup>
			 <col width="7%" />
			 <col width="15.5%" />
			 <col width="15.5%" />
			 <col width="15.5%" />
			 <col width="15.5%" />
			 <col width="15.5%" />
			 <col width="15.5%" />
			 </colgroup>
                 <tr><th colspan="7" class="tt">객실요금</th></tr>
			 <tr>
			 	<th>객실 구분</th>
				<th>도미토리룸<br />(소수정원 4인실)</th>
				<th>1 인실</th>
				<th>2 인실</th>
				<th>2 인실 (프리미엄)</th>
				<th>3 인실</th>
				<th>4 인실</th>
			</tr>

			 <tr>
				<th>객실 구성</th>
				<td>객실내 전용욕실+에어컨</td>
				<td>객실내 전용욕실+에어컨</td>
				<td>객실내 전용욕실+에어컨</td>
				<td>객실내 전용욕실+에어컨</td>
				<td>객실내 전용욕실+에어컨</td>
				<td>객실내 전용욕실+에어컨</td>
			 </tr>

			 <tr>
				<th>비수기</th>
				<td>30유로</td>
				<td>80유로</td>
				<td>90유로</td>
				<td>120유로</td>
				<td>120유로</td>
				<td>150유로</td>
			 </tr>	

			 <tr>
				<th>성수기</th>
				<td>30유로</td>
				<td>90유로</td>
				<td>100유로</td>
				<td>130유로</td>
				<td>130유로</td>
				<td>160유로</td>
			 </tr>				 		 
			 
			 <tr>
				<td colspan="7">
					<p style="line-height: 18px;"><!-- <i class="fa fa-tags" aria-hidden="true"></i> -->
					<strong>※ 성수기: 크리스마스, 겨울방학, 구정(12.20~2월) 하계여행시즌시작(4월~10월)</strong><br /> ※ 예약일정에 따라 이탈리아 정식숙박업 규정에 준해 도시세(CITYTAX)일부 부과됩니다. <br/>
					※ 2017년 겨울 비수기(개인객실) 이벤트 부분은 예약 게시판 공지사항을 참고하세요.  <br/>
					</p>
				</td>
			 </tr>

			 <tr>
				<td colspan="7">
					<p class="pdT5 pdB5 fs13 fw600 fc_poing tar" style="padding-right:18px;">※ 계좌안내 : 국민은행 877002-01-169607(서동혁)</p>
				</td>
			 </tr>			 
</tbody>
		</table>
        
         <footer clss="clearfix">
    	<p class="clb pdT12 fs12 lh19">
		  <strong class="lsm1">상호명</strong> 펠리치타로마	  
            <strong class="lsm1">대표자</strong> 정은지 
		 

		  <span class="blind78"><br /></span>

		  <strong style="padding-left:2px;">현지전화</strong> 0039-340-123-4567		  <strong style="padding-left:2px;">인터넷전화</strong> 070-2222-2555	      <strong>E-MAIL</strong> feliroma@naver.com	
            <br />
        <strong class="lsm1">입금계좌</strong> 국민은행 877002-01-123456(정은지)

		  <br />

		</p>
	</footer>
        </div>
        
<script src="resources/js/jquery-3.1.1.min.js"></script>
<script src="resources/js/script.js"></script>
</body>
</html>