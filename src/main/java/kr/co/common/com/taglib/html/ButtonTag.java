package kr.co.common.com.taglib.html;

import java.io.IOException;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.common.com.utils.StringUtil;

/**
 * 설 명 : 권한체크 후 버튼 보이기/숨기기 처리
 * @author 개발팀 Bang-ji-hwan
 * @since 2018. 7. 26.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자              수정내용
 *  -------       --------    ---------------------------
 *  2018. 7. 26.     bjh                최초 생성
 *  2018. 7. 26.     lcy                수정
 * </pre>
 */
public class ButtonTag extends DefaultTagSupport {
	private Logger log = LoggerFactory.getLogger(this.getClass());

	private static final long serialVersionUID = -3845824886278697801L;

	/* 구분자 add:추가, del:삭제, read:조회, excel:엑셀다운, cap:캡쳐 , report:리포트*/
	private String gubun;
	/* 스크립트 function등 */
	private String script;
	/* 버튼명 */
	private String title;
	/* 이미지 url */
	private String url;
	/* 클래스명 */
	private String classNm;
	/* a 태그 ID */
	private String id;
	/* 이미지 사용여부 */
	private String imgYn;

	public int doStartTag() throws JspException {
		return (SKIP_BODY);
	}

	@SuppressWarnings("unchecked")
	public int doEndTag() throws JspException {
		Map<String, Object> map = (Map<String, Object>) super.pageContext.getRequest().getAttribute("menuMap");

		JspWriter out = super.pageContext.getOut();
		StringBuffer html = new StringBuffer();

		String imgUrl = "";
		String title = "";
		if (map != null) {
			
			String roleYn = StringUtil.noNull(map.get("priv")); //사용자 권한에 대한 롤
			//권한여부 'U',등록권한 'A',삭제권한 'D',읽기권한 'R',수정권한 'S'
			
			String viewYn = StringUtil.noNull(map.get("use_cd")); //메뉴 에 버튼이 보이나 안보이나
			//추가 'A'삭제 'D',조회 'R',엑셀 'E'     
			
				
			if(StringUtil.noNull(classNm).equals("")) classNm = "btn_1";

			if (gubun.equals("add") && roleYn.contains("A")&&viewYn.contains("A") ) {
				title = StringUtil.noNull(this.title, "등 록");
				buttonCreate(html, title, imgUrl);
			} else if (gubun.equals("del") &&  roleYn.contains("D")&&viewYn.contains("D") ) {
				title = StringUtil.noNull(this.title, "삭 제");
				buttonCreate(html, title, imgUrl);
			} else if (gubun.equals("read") &&  roleYn.contains("R")&&viewYn.contains("R") ) {
				title = StringUtil.noNull(this.title, "조 회");
				buttonCreate(html, title, imgUrl);
			} else if (gubun.equals("excel") && roleYn.contains("R")&& viewYn.contains("E") ) {
				title = StringUtil.noNull(this.title, "Excel");
				buttonCreate(html, title, imgUrl);
			} else if (gubun.equals("etc")) {
				buttonCreate(html, title, imgUrl);
			}
		} else {
			if (gubun.equals("etc")) {
				buttonCreate(html, title, imgUrl);
			}
		}
		try {
			out.print(html.toString());
		} catch (IOException e) {
			log.info("IOException: " + e.toString());
		}
		return (SKIP_BODY);
	}

	/**
	 * 버튼 생성
	 * 
	 * @param html
	 * @param title
	 * @param imgUrl
	 */
	public void buttonCreate(StringBuffer html, String title, String imgUrl) {
		String classNm = "white";
		if (this.title != null) {
			title = this.title;
		}
		if (this.url != null) {
			imgUrl = this.url;
		}
		if (this.classNm != null) {
			classNm = this.classNm;
		}
		if (this.imgYn == null) {
			this.imgYn = "Y";
		}
		if (!title.equals("")) {
			html.append("<button href='#' class='" + classNm + "' title='" + title + "'");
			if (this.id != null) {
				html.append(" id='" + this.id + "'");
			}
			if (this.script != null) {
				html.append(" onclick=\"" + script + "\"");
			}
			html.append(" >");
			if (!imgUrl.equals("") && imgYn.equals("Y")) {
				html.append("<img src='" + imgUrl + "' alt='" + title + "' /> ");
			}
			html.append(title + "</button>");
		}
	}

	public String getGubun() {
		return gubun;
	}

	public void setGubun(String gubun) {
		this.gubun = gubun;
	}

	public String getScript() {
		return script;
	}

	public void setScript(String script) {
		this.script = script;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}


	public String getClassNm() {
		return classNm;
	}

	public void setClassNm(String classNm) {
		this.classNm = classNm;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getImgYn() {
		return imgYn;
	}

	public void setImgYn(String imgYn) {
		this.imgYn = imgYn;
	}

}
