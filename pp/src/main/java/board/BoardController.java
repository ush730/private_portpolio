package board;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	@Autowired
	private CommentService cService;
		
	@RequestMapping("/portfolio/board/index.do")
	public String index(HttpServletRequest req, BoardVo vo) {
		// 서비스(로직) 처리(호출)
		int[] rowPageCount = boardService.getRowPageCount(vo);
		List<BoardVo> list = boardService.getList(vo);
			
		// 값 저장
		// totalPage, list, reqPage
		req.setAttribute("totalPage", rowPageCount[1]);
		req.setAttribute("startPage", rowPageCount[2]); // 시작페이지
		req.setAttribute("endPage", rowPageCount[3]); // 마지막페이지
		req.setAttribute("list", list);
		// /portfolio/board/index.do?reqPage=2 -> BoardVo에 reqPage 필드에 바인딩 (커맨드객체)
		// /portfolio/board/index.do
		req.setAttribute("reqPage", vo.getReqPage());
		req.setAttribute("vo", vo);
			
		// jsp 포워딩
		return "portfolio/board/index";
	}
		
		@RequestMapping("/portfolio/board/detail.do")
		public String detail(HttpServletRequest req, BoardVo vo) {
			
			BoardVo uv = boardService.selectOne(vo, false);
			List<CommentVo> clist = cService.getList(uv.getBoard_no());
			
			req.setAttribute("vo", uv);
			req.setAttribute("clist", clist);
			
			// jsp 포워딩
			return "portfolio/board/detail";
		}
		
		@GetMapping("/portfolio/board/write.do")
		public String write() {
			return "portfolio/board/write";
		}
		
		@RequestMapping("/portfolio/board/insert.do")
		public void insert(BoardVo vo, HttpServletRequest req, HttpServletResponse res, MultipartFile file) throws Exception {
			// 등록처리
			//res.getWriter().print(boardService.insert(vo));
			
			// 파일을 저장
			if (!file.isEmpty()) { // 사용자가 첨부한 파일이 있으면
				try {
					String ext = "";
					if (file.getOriginalFilename().indexOf(".") > -1 ) { // 파일명에 . 이 포함되어있는 경우
						ext = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
						System.out.println(ext);
					}
					String filename = new Date().getTime()+ext;
					
					
					// request.getRealPath() -> 실제 경로를 리턴
					String path = req.getRealPath("/upload/");
					System.out.println(path);
					//path = "D:\\AI\\workspace\\user\\src\\main\\webapp\\upload\\";
					file.transferTo(new File(path+filename));
					// 파일명을 vo에 저장
					vo.setFilename(filename);
					vo.setFilename_org(file.getOriginalFilename());
				} catch (Exception e) {
					System.out.println(e.toString());
				}
			}
			
			res.setContentType("text/html;charset=utf-8");
			PrintWriter out = res.getWriter();
			out.print("<script>");
			if (boardService.insert(vo)) {
				out.print("alert('정상적으로 등록되었습니다.');");
				out.print("location.href='/pp/portfolio/board/index.do';");
			} else {
				out.print("alert('등록실패.');");
				out.print("history.back();");
			}
			out.print("</script>");
			out.flush();
		}
		
		@RequestMapping("/portfolio/board/edit.do")
		public String edit(HttpServletRequest req, BoardVo vo) {
			
			BoardVo uv = boardService.selectOne(vo, true);
			
			req.setAttribute("vo", uv);
			
			// jsp 포워딩
			return "portfolio/board/edit";
		}
		
		@PostMapping("/portfolio/board/update.do")
		public void update(BoardVo vo, HttpServletResponse res, HttpServletRequest req, MultipartFile file) throws IOException {
			//res.getWriter().print(boardService.update(vo));
			// 파일을 저장
			if (!file.isEmpty()) { // 사용자가 첨부한 파일이 있으면
				try {
					String ext = "";
					if (file.getOriginalFilename().indexOf(".") > -1 ) { // 파일명에 . 이 포함되어있는 경우
						ext = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
						System.out.println(ext);
					}
					String filename = new Date().getTime()+ext;
					
					
					// request.getRealPath() -> 실제 경로를 리턴
					String path = req.getRealPath("/upload/");
					System.out.println(path);
					//path = "D:\\AI\\workspace\\user\\src\\main\\webapp\\upload\\";
					file.transferTo(new File(path+filename));
					// 파일명을 vo에 저장
					vo.setFilename(filename);
					vo.setFilename_org(file.getOriginalFilename());
				} catch (Exception e) {
					System.out.println(e.toString());
				}
			}
			
			res.setContentType("text/html;charset=utf-8");
			PrintWriter out = res.getWriter();
			out.print("<script>");
			if (boardService.update(vo)) {
				out.print("alert('정상적으로 수정되었습니다.');");
				out.print("location.href='/portfolio/board/detail.do?no="+vo.getBoard_no()+"';");
			} else {
				out.print("alert('수정실패.');");
				out.print("history.back();");
			}
			out.print("</script>");
			out.flush();
		}
		
		@GetMapping("/portfolio/board/delete.do")
		public void delete(BoardVo vo, HttpServletResponse res) throws IOException {
			res.getWriter().print(boardService.delete(vo));
		}
		
		@RequestMapping("/portfolio/board/commentInsert.do")
		public void commentInsert(CommentVo vo, HttpServletRequest req, HttpServletResponse res, MultipartFile file) throws Exception {
		
			res.setContentType("text/html;charset=utf-8");
			PrintWriter out = res.getWriter();
			out.print("<script>");
			if (cService.insert(vo)) {
				out.print("alert('정상적으로 등록되었습니다.');");
				out.print("location.href='/portfolio/board/detail.do?no="+vo.getBoard_no()+"';");
			} else {
				out.print("alert('등록실패.');");
				out.print("history.back();");
			}
			out.print("</script>");
			out.flush();
		}
		
		@GetMapping("/portfolio/board/commentDelete.do")
		public void commentDelete(CommentVo vo, HttpServletResponse res) throws IOException {
			res.setContentType("text/html;charset=utf-8");
			PrintWriter out = res.getWriter();
			out.print("<script>");
			if (cService.delete(vo.getNo())) {
				out.print("alert('정상적으로 삭제되었습니다.');");
				out.print("location.href='/portfolio/board/detail.do?no="+vo.getBoard_no()+"';");
			} else {
				out.print("alert('삭제실패.');");
				out.print("history.back();");
			}
			out.print("</script>");
			out.flush();
		
		}

}

