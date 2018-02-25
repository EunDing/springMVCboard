package kr.koreait.springRboard_0201;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.swing.JOptionPane;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.koreait.DAO.MybatisDAO;
import kr.koreait.VO.RboardCommentList;
import kr.koreait.VO.RboardCommentVO;
import kr.koreait.VO.RboardList;
import kr.koreait.VO.RboardVO;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "main";
	}
	
//	mybatis를 사용하기 위해 SqlSession 객체를 @Autowired 어노테이션을 붙여서 선언한다.
//	서버가 실행될 때 servlet-context.xml에 선언된 mybatis mapper가 @Autowired 어노테이션을 붙여서 선언한
//	SqlSession 타입의 객체에 자동으로 저장된다.
	@Autowired
	private SqlSession sqlSession;
	
	AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");

	@RequestMapping("/main")
	public String main(HttpServletRequest request, Model model) {
		System.out.println("main()");
		return "main";
	}
	
	@RequestMapping("/introduce")
	public String introduce(HttpServletRequest request, Model model) {
		System.out.println("introduce()");
		return "introduce";
	}
	
	@RequestMapping("/room")
	public String room(HttpServletRequest request, Model model) {
		System.out.println("room()");
		return "room";
	}
	
	@RequestMapping("/way")
	public String way(HttpServletRequest request, Model model) {
		System.out.println("way()");
		return "way";
	}
	
	@RequestMapping("/insert")
	public String insert(HttpServletRequest request, Model model) {
		System.out.println("insert()");
		return "insert";
	}
	
	@RequestMapping("/insertOK")
	public String insertOK(HttpServletRequest request, Model model) {
		System.out.println("insertOK()");
		
		String ip = request.getParameter("ip");
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String notice = request.getParameter("notice");
		//정말 이해 노노하지만 notice가 null이면 아예 넘어가질 않아서 임시방편처리
		if(notice == null) {
			notice = "no";
		}
		
//		controller와 SQL 명령이 저장된  xml 파일을 연결하는 임의의 이름으로 인터페이스를 만들고 인터페이스 
//		객체로 mapper 를 얻어온다.
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		RboardVO vo = ctx.getBean("vo", RboardVO.class);
		
		vo.setIp(ip);
		vo.setName(name);
		vo.setPassword(password);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setNotice(notice);
		System.out.println(notice);
		mapper.insert(vo);
		return "redirect:list";
	}
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model) {
		System.out.println("list()");
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		int currentPage = 1;
		int pageSize = 10;
		int totalCount = mapper.selectCount();
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (Exception e) {}

		
		ArrayList<RboardVO> notice = mapper.selectNotice();
		model.addAttribute("notice", notice);
		
		RboardList list = new RboardList(pageSize, totalCount, currentPage);
		
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("startNo", list.getStartNo());
		hmap.put("endNo", list.getEndNo());

		list.setList(mapper.selectList(hmap));
		
		//댓글의 개수 얻어오기
		for(RboardVO vo : list.getList()){
			vo.setReplyCount(mapper.replyCount(vo.getIdx()));
		}  
		
		model.addAttribute("list", list);
		return "list";
	}
	
	@RequestMapping("/increment")
	public String increment(HttpServletRequest request, Model model) {
		System.out.println("increment()");
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		mapper.increment(idx);
		model.addAttribute("idx",idx);
		model.addAttribute("currentPage", currentPage);
		
		return "redirect:view";
	}
	
	
	@RequestMapping("/view")
	public String view(HttpServletRequest request, Model model) {
		System.out.println("view()");
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		RboardVO vo = mapper.selectByIdx(idx);
		
		//댓글목록 보여주기
		RboardCommentList commentList = new RboardCommentList();
		commentList.setList(mapper.selectCommentList(idx));
		model.addAttribute("commentList", commentList);
		
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("vo", vo);
		return "view";
	}
	
	@RequestMapping("/delete")
	public String delete(HttpServletRequest request, Model model) {
		System.out.println("delete()");
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		model.addAttribute("currentPage", currentPage);
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		RboardVO vo = mapper.selectByIdx(idx);
	
		model.addAttribute("vo", vo);
		return "delete";
	}

	@RequestMapping("/deleteOK")
    public String deleteOK( HttpServletRequest request, Model model) {
		
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
        int idx = Integer.parseInt(request.getParameter("idx"));
        int currentPage = Integer.parseInt(request.getParameter("currentPage"));
        String password =  request.getParameter("password");

        RboardVO original = mapper.selectByIdx(idx);
        String url="";
        model.addAttribute("currentPage", currentPage);
        if(original.getPassword().trim().equals(password)){   
            mapper.delete(idx); 
    		JOptionPane.showMessageDialog(null, idx + " 번 글 삭제완료");
    		url = "redirect:list";
        }else{
        	JOptionPane.showMessageDialog(null,"비밀번호가 올바르지 않습니다.");
            url="redirect:delete?idx="+idx+"&currentPage="+currentPage;
        }
        return url;
    }
	
	@RequestMapping("/update")
	public String update(HttpServletRequest request, Model model) {
		System.out.println("delete()");
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		model.addAttribute("currentPage", currentPage);
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		RboardVO vo = mapper.selectByIdx(idx);
		
		model.addAttribute("vo", vo);
		mapper.update(vo);
		return "update";
	}
	
	
	@RequestMapping("/updateOK")
    public String updateOK( HttpServletRequest request, Model model) {
		
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
        String title =  request.getParameter("title");
        String content =  request.getParameter("content");
        String password =  request.getParameter("password");
        String notice =  request.getParameter("notice");
    	//정말 이해 노노하지만 notice가 null이면 아예 넘어가질 않아서 임시방편처리
		if(notice == null) {
			notice = "no";
		}
        RboardVO original = mapper.selectByIdx(idx);
        RboardVO vo = ctx.getBean("vo", RboardVO.class);
        
        vo.setIdx(idx);
        vo.setTitle(title);
        vo.setContent(content);
        vo.setNotice(notice);
        model.addAttribute("currentPage", currentPage);
        String url="";
        
        if(original.getPassword().trim().equals(password)){   
            mapper.update(vo); 
    		JOptionPane.showMessageDialog(null, idx + " 번 글 수정완료");
    		url = "redirect:list";
        }else{
        	JOptionPane.showMessageDialog(null,"비밀번호가 올바르지 않습니다.");
        	url="redirect:update?idx="+idx+"&currentPage="+currentPage;
        }
        return url;
    }
	
	@RequestMapping("reply")
	public String reply(HttpServletRequest request, Model model) {
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		model.addAttribute("currentPage", currentPage);
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		RboardVO vo = mapper.selectByIdx(idx);
		model.addAttribute("vo", vo);
		
		return "reply";
	}
	
	@RequestMapping("/replyOK")
	public String replyOK(HttpServletRequest request, Model model) {
		System.out.println("replyOK()");

		int idx = Integer.parseInt(request.getParameter("idx"));
		int ref = Integer.parseInt(request.getParameter("ref"));
		int lev = Integer.parseInt(request.getParameter("lev")) + 1;
		int seq = Integer.parseInt(request.getParameter("seq")) + 1;
		
		String ip = request.getParameter("ip");
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String title =  request.getParameter("title");
		String content = request.getParameter("content");
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		model.addAttribute("currentPage", currentPage);
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("ref", ref);
		hmap.put("seq", seq);
		
		mapper.replyIncrement(hmap);
		
		RboardVO vo = ctx.getBean("vo", RboardVO.class);
		
		vo.setIdx(idx);
		vo.setRef(ref);
		vo.setLev(lev);
		vo.setSeq(seq);
		
		vo.setIp(ip);
		vo.setName(name);
		vo.setPassword(password);
		vo.setTitle(title);
		vo.setContent(content);
		
		mapper.replyInsert(vo);
		
		return "redirect:list";
	}
	

	//댓글저장, 수정, 삭제
	@RequestMapping("/commentOK")
	public String comment(HttpServletRequest request, Model model) {
		System.out.println("commentOK()");
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		int ref = Integer.parseInt(request.getParameter("ref"));
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String content = request.getParameter("content");
		String ip = request.getParameter("ip");
		int mode = Integer.parseInt(request.getParameter("mode"));
		
		RboardCommentVO cmvo = ctx.getBean("cmvo", RboardCommentVO.class);
		
		cmvo.setIdx(idx);
		cmvo.setRef(ref);
		cmvo.setName(name);
		cmvo.setPassword(password);
		cmvo.setContent(content);
		cmvo.setIp(ip);
		
//		비교하기 위해 수정 또는 삭제할 댓글 한 건을 얻어온다.
		RboardCommentVO original = mapper.selectCommentByIdx(idx);
		
		String url="redirect:view?idx="+ref+"&currentPage="+currentPage;
		switch (mode) {
				case 1:
					mapper.insertComment(cmvo);
					break;
				case 2:
					if(original.getPassword().trim().equals(password)){  
						mapper.updateComment(cmvo);
						JOptionPane.showMessageDialog(null, "댓글 수정완료");
					}else{
						JOptionPane.showMessageDialog(null,"비밀번호가 올바르지 않습니다.");
					}
					break;
				case 3:
					if(original.getPassword().trim().equals(password)){  
						mapper.deleteComment(cmvo);
						JOptionPane.showMessageDialog(null, "댓글 삭제완료");
					}else{
						JOptionPane.showMessageDialog(null,"비밀번호가 올바르지 않습니다.");
					}
					break;
			
			}
		return url;
	}
}


