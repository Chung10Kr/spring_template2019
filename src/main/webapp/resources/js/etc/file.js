    // 파일 리스트 번호
    var fileIndex = 0;
    // 등록할 전체 파일 사이즈
    var totalFileSize = 0;
    // 파일 리스트
    var fileList = new Array();
    // 파일 사이즈 리스트
    var fileSizeList = new Array();
    // 등록 가능한 파일 사이즈 MB
    var uploadSize = 50;
    // 등록 가능한 총 파일 사이즈 MB
    var maxUploadSize = 500;
 
    $(function (){
        // 파일 드롭 다운
        fileDropDown();
    });
 
    // 파일 드롭 다운
    function fileDropDown(){
        var dropZone = $(".dropZone");
        //Drag기능 
        dropZone.on('dragenter',function(e){
            e.stopPropagation();
            e.preventDefault();
            // 드롭다운 영역 css
            dropZone.css('background-color','#E3F2FC');
        });
        dropZone.on('dragleave',function(e){
            e.stopPropagation();
            e.preventDefault();
            // 드롭다운 영역 css
            dropZone.css('background-color','#FFFFFF');
        });
        dropZone.on('dragover',function(e){
            e.stopPropagation();
            e.preventDefault();
            // 드롭다운 영역 css
            dropZone.css('background-color','#E3F2FC');
        });
        dropZone.on('drop',function(e){
            e.preventDefault();
            // 드롭다운 영역 css
            dropZone.css('background-color','#FFFFFF');
            
            var files = e.originalEvent.dataTransfer.files;
            if(files != null){
                if(files.length < 1){
                    alert("폴더 업로드 불가");
                    return;
                }
                selectFile(files);
            }else{
                alert("ERROR");
            }
        });
    }
 
    // 파일 선택시
    function selectFile(files){
        // 다중파일 등록
        if(files != null){
            for(var i = 0; i < files.length; i++){
                // 파일 이름
                var fileName = files[i].name;
                var fileNameArr = fileName.split("\.");
                // 확장자
                var ext = fileNameArr[fileNameArr.length - 1];
                // 파일 사이즈(단위 :MB)
                var fileSize = files[i].size / 1024 / 1024;
                
                if($.inArray(ext, ['exe', 'bat', 'sh', 'java', 'jsp', 'html', 'js', 'css', 'xml']) >= 0){
                    // 확장자 체크
                    alert("등록 불가 확장자");
                    break;
                }else if(fileSize > uploadSize){
                    // 파일 사이즈 체크
                    alert("용량 초과\n업로드 가능 용량 : " + uploadSize + " MB");
                    break;
                }else{
                    // 전체 파일 사이즈
                    totalFileSize += fileSize;
                    
                    // 파일 배열에 넣기
                    fileList[fileIndex] = files[i];
                    
                    // 파일 사이즈 배열에 넣기
                    fileSizeList[fileIndex] = fileSize;
 
                    // 업로드 파일 목록 생성
                    addFileList(fileIndex, fileName, fileSize);
 
                    // 파일 번호 증가
                    fileIndex++;
                }
            }
        }else{
            alert("ERROR");
        }
    }
 
    // 업로드 파일 목록 생성
    function addFileList(fIndex, fileName, fileSize){
        var html = "";
        html += "<div id='fileTr_" + fIndex + "'>";
        html +=         fileName + " / " + fileSize + "MB "  + "<a href='' onclick='deleteFile(" + fIndex + "); return false;' class=>삭제</a>";
        html += "</div>";
     
        $('.fileZone').append(html);
    }
 
    // 업로드 파일 삭제
    function deleteFile(fIndex){
        // 전체 파일 사이즈 수정
        totalFileSize -= fileSizeList[fIndex];
        
        // 파일 배열에서 삭제
        delete fileList[fIndex];
        
        // 파일 사이즈 배열 삭제
        delete fileSizeList[fIndex];
        
        // 업로드 파일 테이블 목록에서 삭제
        $("#fileTr_" + fIndex).remove();
    }
 
    // 파일 등록
    function uploadFile(){
        // 등록할 파일 리스트
        var uploadFileList = Object.keys(fileList);
        
        // 파일이 있는지 체크
        if(uploadFileList.length != 0){
            // 용량을 500MB를 넘을 경우 업로드 불가
            if(totalFileSize > maxUploadSize){
                // 파일 사이즈 초과 경고창
                alert("총 용량 초과\n총 업로드 가능 용량 : " + maxUploadSize + " MB");
                return;
            }
            // 등록할 파일 리스트를 formData로 데이터 입력
            var formData = new FormData();
            for(var i = 0; i < uploadFileList.length; i++){
                formData.append('file', fileList[uploadFileList[i]]);
            }
            
            $.ajax({
                url:'/UTL/FILE/upload',
                type:'POST',
                data:formData,
                enctype:'multipart/form-data',
                async: false,
                processData:false,
                contentType:false,
                dataType:'json',
                cache:false,
                success:function(result){
                    $("#fileSeq").val(result);
                },
                error : function(xhr, status, error){
                	alert("시스템 오류가 발생하였습니다.");
		        },
            });
        		
        };
        
    }

  /**
 * 함수 설명 : 파일 다운로드 
 * @param id  :  file_id
 */
  
  function fileDown(id){
	if(id == ""){
		return false;
	};
	var url = "/UTL/FILE/down";
	
	$.fileDownload(url,{
        httpMethod:'POST', 
        data: {file_seq:id}
       })
       .done(function (url) {
    	   stopBluckUi();
       })
       .fail(function (responseHtml, url) {
    	   stopBluckUi();
    	   alert("시스템 오류가 발생하였습니다.\n잠시후에 사용하시기 바랍니다.");
       });
  };
  //업로드 시 파일 삭제
  function deleteFileList(obj){
	  $(obj).parent().remove();
  }

	
 

 


