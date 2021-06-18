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
<script>
function addAction(){
// 		$("#f_boardAdd").attr("method","post");
// 		$("#f_boardAdd").attr("enctype","multipart/form-data");
		$("#f_boardAdd").attr("action","./boardInsert.sp4");
		$("#f_boardAdd").submit();
		//부모창에 함수를 호출할때 opener.함수명();
		//opener.boardList();
		//self.close();
	}
	function updateForm(){
		//alert("updateForm 호출 성공");
// 		$('#d_boardUpd').dialog({
// 			title:'글수정'
// 		  ,width:720
// 		  ,height:450
// 		  ,closed:false
// 		  ,cache:false
// 		 ,modal:true	  
// 		});		
		$('#f_detail').attr("method", "post");
		$('#f_detail').attr("action", "./boardUpdate.sp4");
		
		$('#f_detail').submit();
		//$('#d_boardUpd').dialog('open');	
		//$('#d_boardUpd').dialog('refresh', '');
	}
	//글삭제하기 이벤트 처리
	function boardDelView(){
		alert("boardDelView호출 성공");
// 		  $('#d_boardDel').dialog({
// 			    title: '글삭제',
// // 			    buttons: btn_boardDel,
// 			    width: 420,
// 			    height: 250,
// 			    closed: true,
// 			    cache: false,
<%-- 			    href: "./boardDelete.sp4?bm_no=<%=rb_no%>&bm_pw=<%=rb_pwd%>" , --%>
// 			    modal: true
// 	   }); 	
	   $('#f_detail').attr("method", "post");		
	   $('#f_detail').attr("action", "./boardDelete.sp4");		
	   $('#f_detail').submit();
// 	   $('#d_boardDel').dialog('open');		
	}
	//댓글쓰기
	function repleForm() {
		$("#dlg_boardAdd").dialog('open');
	}
	function boardList(){
		location.href = "./getBoardList.sp4";
	}
	
	//글삭제 화면에서 확인 버튼을 클릭했을 때
	function boardDel(){
		var db_pw = <%=rb_pwd %>
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