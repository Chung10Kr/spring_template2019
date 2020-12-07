package kr.co.common.utl.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;

import kr.co.common.com.controller.DefaultController;
import kr.co.common.com.utils.WebConfig;
import kr.co.common.utl.file.service.FileService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;


/**
 * 설 명 : 파일 업로드 관리
 * @author 개발팀  Lee_chung_ryeol
 * @since 2019. 11. 11.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자              수정내용
 *  -------       --------    ---------------------------
 *  2019. 11. 11.       lcy         최초 생성
 *  2019. 12. 20.       lcy         다중 파일 업로드 수정
 * </pre>
 */
@Controller
public class FileController extends DefaultController {

	private Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "FileService")
	private FileService fileService;

	
	@ResponseBody
	@RequestMapping(value = "/UTL/FILE/upload")
	public List<String> fileUpload(MultipartHttpServletRequest multipartRequest) throws Exception {
		
		//설정파일에서 경로 가져옴
		String filePath = WebConfig.getProperty("fileUpload.path");
		
		
		//오늘 날짜 폴더를 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Calendar c1 = Calendar.getInstance();
	    String strToday = sdf.format(c1.getTime());
	    filePath = "/"+filePath+"/"+strToday;
	    
		File Folder = new File(filePath);
        if (!Folder.exists()) {
            Folder.mkdir(); //폴더 생성합니다.
      	};
		
      	//시간초 + 파일명 => seq
      	SimpleDateFormat format1 = new SimpleDateFormat ( "HHmmss");
		String time1 = format1.format(new Date());
		
      	//파일 저장
        List<String> seqs = new ArrayList<String>();
        String seq = null;
        List<MultipartFile> uploadFileList = ((MultipartHttpServletRequest)request).getFiles("file");
		int size = uploadFileList.size();
		if ( uploadFileList != null && size > 0 ) {
			for (MultipartFile files : uploadFileList) {
				if ( !files.isEmpty() ) {
				  String originalFilename = files.getOriginalFilename(); // 파일이름
				  String seq_file_name = time1+"_"+originalFilename;
		          String fileFullPath = filePath+"/"+seq_file_name; //파일 전체 경로
		          
		          try {
		                //파일 저장
		        	  	files.transferTo(new File(fileFullPath));
		                
		                seq = fileService.fileSeq().get("seq").toString();
		                seqs.add(seq);
		                commandMap.put("seq",seq);
		                commandMap.put("real_file_name",  originalFilename );
		                commandMap.put("seq_file_name",  seq_file_name );
		                
		                commandMap.put("file_path",  fileFullPath );
		                fileService.insert(commandMap);
		                
		            } catch (Exception e) {
		                log.debug("fileUploadError" + e);
		            };
				 };
			};
		}
        return seqs;
    };
    
    @RequestMapping(value = "/UTL/FILE/down")
    public void download()  throws Exception{
        Map<String,Object> fileMap = fileService.getFile(commandMap);

        File file = new File(fileMap.get("file_path").toString());
    	
        response.setContentType("application/download; utf-8");
        response.setContentLength((int)file.length());
         
        String realName = fileMap.get("real_file_name").toString();
         
        response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(realName, "utf-8") + ";");
        response.setHeader("Content-Transfer-Encoding", "binary");
        /*OutputStream out = response.getOutputStream();*/
        OutputStream out = response.getOutputStream();
        
        FileInputStream fis = null;
        
        //파일 카피 후 마무리
        try {
            fis = new FileInputStream(file);
            FileCopyUtils.copy(fis, out);
        } catch(Exception e){
            e.printStackTrace();
        }finally{
            if(fis != null){
                try{
                    fis.close();
                }catch(Exception e){}
            }
        }// try end;
        out.flush();
        
    }

	
	
}
