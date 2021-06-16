<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
	StringBuilder path = new StringBuilder(request.getContextPath());
path.append("/");
List<Map<String, Object>> boardDetail = null;
boardDetail = (List<Map<String, Object>>) request.getAttribute("boardDetail");
int size = 0;
if (boardDetail != null) {
	size = boardDetail.size();
}
out.print("size : " + size);

String rb_email = null;
String rb_file = null;
String rb_title = null;
String rb_writer = null;
String rb_content = null;
String rb_pwd = null;
String rb_no = null;
String rb_group = null;
String rb_pos = null;
String rb_step = null;
if (boardDetail != null && boardDetail.size() > 0) {
	rb_email 	= (String)boardDetail.get(0).get("BM_EMAIL");
	rb_file 	= (String)boardDetail.get(0).get("BS_FILE");
	rb_title	= (String)boardDetail.get(0).get("BM_TITLE");
	rb_writer 	= (String)boardDetail.get(0).get("BM_WRITER");
	rb_content 	= (String)boardDetail.get(0).get("BM_CONTENT");
	rb_pwd 		= (String)boardDetail.get(0).get("BM_PW");
	rb_no 		= boardDetail.get(0).get("BM_NO").toString();
	rb_group 	= boardDetail.get(0).get("BM_GROUP").toString();
	rb_pos 		= boardDetail.get(0).get("BM_POS").toString();
	rb_step 	= boardDetail.get(0).get("BM_STEP").toString();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../../../common/commonUIglobal.jsp" flush="false" />
<script type="text/javascript">
	function addAction(){
		$("#f_boardAdd").attr("method","post");
		$("#f_boardAdd").attr("action","/board/boardList.mvc?crud=ins");
		$("#f_boardAdd").submit();
		//부모창에 함수를 호출할때 opener.함수명();
		//opener.boardList();
		//self.close();
	}
	function updateForm(){
		//alert("updateForm 호출 성공");
		$('#d_boardUpd').dialog({
			title:'글수정'
		  ,width:720
		  ,height:450
		  ,closed:false
		  ,cache:false
		 ,modal:true	  
		});
		//$('#d_boardUpd').dialog('open');	
		//$('#d_boardUpd').dialog('refresh', '');
	}
	//댓글쓰기
	function repleForm() {
		$("#dlg_boardAdd").dialog('open');
	}
	function boardList(){
		location.href = "../board/getBoardList.sp4";
	}
	//글삭제하기 이벤트 처리
	function boardDelView(){
		alert("boardDelView호출 성공");
		  $('#d_boardDel').dialog({
			    title: '글삭제',
			    buttons: btn_boardDel,
			    width: 420,
			    height: 250,
			    closed: true,
			    cache: false,
			    //href: 'boardDelForm.jsp?bm_no=<%=rb_no%>&bm_pw=<%=rb_pwd%>',
			    modal: true
	   }); 
	   $('#d_boardDel').dialog('open');		
	}
	//글삭제 화면에서 확인 버튼을 클릭했을 때
	function boardDel(){
		var db_pw = <%=rb_pwd%>
		var u_pw = $("#u_pw").textbox('getValue');
		//alert("db_pw:"+db_pw+", u_pw:"+u_pw);
		//alert("사용자가 입력한 비번:"+$("#db_pw").textbox('getValue'));
		//사용자가 입력한 비번과 DB에서 읽어온 비번을 비교하여
		//일치하면 삭제 처리 진행하고
		//불일치하면 비번을 다시 입력받도록 해주세요.
		if(u_pw==db_pw){
			//alert("같다");
			$.messager.confirm('Confirm','정말 삭제하시겠습니까?',function(r){
			 //r:true-ok, false-cancel
				if (r){//자바스크립트는 0이면 false 나머지 true
			    	location.href="./boardList.mvc?crud=del&bm_no=<%=rb_no%>&bs_file=<%=rb_file%>";    
			    }
			});
		}else{
			$("#db_pw").textbox('setValue','');
		}
	}
	function boardDelClose(){
		 $('#d_boardDel').dialog('close');
	}
// 	function boardList(){
// 		location.href="/board/boardList.jsp";
// 	}
</script>
</head>
<body>
	<table align="center" id="p" class="easyui-panel" title="글상세보기" data-options="footer:'#tb_read'" style="width: 670px; height: 380px; padding: 10px; background: #fafafa;">
		<tr>
			<td>제목</td>
			<td>
				<input id="bm_title" value="<%=rb_title%>" name="bm_title" data-options="width:'450px'" class="easyui-textbox">
			</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>
				<input id="bm_writer" value="<%=rb_writer%>" name="bm_writer" class="easyui-textbox">
			</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>
				<input id="bm_email" value="<%=rb_email%>" name="bm_email" class="easyui-textbox">
			</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>
				<input id="bm_content" value="<%=rb_content%>" name="bm_content" data-options="multiline:'true', width:'570px', height:'90px'" class="easyui-textbox">
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>
				<input id="bm_pw" value="<%=rb_pwd%>" name="bm_pw" class="easyui-passwordbox">
			</td>
		</tr>
	</table>
	<div id="tb_read" style="padding: 2px 5px;" align="center">
		<a href="javascript:repleForm()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">댓글쓰기</a> 
		<a href="javascript:updateForm()" class="easyui-linkbutton" iconCls="icon-add" plain="true">수정</a>
		<a href="javascript:boardDelView()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">삭제</a> 
		<a href="javascript:boardList()" class="easyui-linkbutton" iconCls="icon-search" plain="true">목록</a>
	</div>

	<!--================== [[댓글쓰기 화면]] ==================-->
	<div id="dlg_boardAdd" title="댓글쓰기" class="easyui-dialog" style="width: 600px; height: 400px; padding: 10px" 
		data-options="closed:'true',modal:'true',footer:'#tbar_boardAdd'">
		<!-- 
form전송시 encType옵션이 추가되면 request객체로 사용자가 입력한 값을 꺼낼 수 없다.
MultipartRequest  => cos.jar
 -->
		<form id="f_boardAdd" method="get">
			<input type="hidden" name="bm_no" value="<%=rb_no%>"> 
			<input type="hidden" name="bm_group" value="<%=rb_group%>"> 
			<input type="hidden" name="bm_pos" value="<%=rb_pos%>"> 
			<input type="hidden" name="bm_step" value="<%=rb_step%>">
			<!-- <form id="f_boardAdd"> -->
			<table>
				<tr>
					<td width="100px">제목</td>
					<td width="500px">
						<input class="easyui-textbox" data-options="width:'350px'" id="bm_title" name="bm_title" required>
					</td>
				</tr>
				<tr>
					<td width="100px">작성자</td>
					<td width="500px">
						<input class="easyui-textbox" data-options="width:'150px'" id="bm_writer" name="bm_writer" required>
					</td>
				</tr>
				<tr>
					<td width="100px">이메일</td>
					<td width="500px">
						<input class="easyui-textbox" data-options="width:'250px'" id="bm_email" name="bm_email">
					</td>
				</tr>
				<tr>
					<td width="100px">내용</td>
					<td width="500px">
						<input class="easyui-textbox" id="bm_content" name="bm_content" data-options="multiline:'true',width:'400px',height:'90px'" required>
					</td>
				</tr>
				<tr>
					<td width="100px">비번</td>
					<td width="500px">
						<input class="easyui-textbox" data-options="width:'100px'" id="bm_pw" name="bm_pw" required>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 입력 화면 버튼 추가 -->
	<div id="tbar_boardAdd" align="right">
		<a href="javascript:addAction()" class="easyui-linkbutton" iconCls="icon-save">저장</a> 
		<a href="javascript:$('#dlg_boardAdd').dialog('close')" class="easyui-linkbutton" iconCls="icon-cancel">닫기</a>
	</div>
	<!-- 댓글쓰기  끝  -->
</body>
</html>