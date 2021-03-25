package gallery;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import board.BoardService;

@Controller
public class GalleryController {

	@Autowired
	private GalleryService GalleryService;
	
	@RequestMapping("/portfolio/gallery/index.do")
	public String index(HttpServletRequest req, GalleryVo vo) {
		// 서비스(로직) 처리(호출)
		// int[] rowPageCount = GalleryService.getRowPageCount(vo);
		List<GalleryVo> list = GalleryService.getList(vo);
		
		// 값 저장
		// totalPage, list, reqPage
		//req.setAttribute("totalPage", rowPageCount[1]);
		//req.setAttribute("startPage", rowPageCount[2]); // 시작페이지
		//req.setAttribute("endPage", rowPageCount[3]); // 마지막페이지
		req.setAttribute("list", list);
		// /portfolio/gallery/index.do?reqPage=2 -> GalleryVo에 reqPage 필드에 바인딩 (커맨드객체)
		// /portfolio/gallery/index.do
//		req.setAttribute("reqPage", vo.getReqPage());
		req.setAttribute("vo", vo);
		
		// jsp 포워딩
		return "gallery/index";
	}
	
	@GetMapping("/portfolio/gallery/write.do")
	public String write() {
		return "gallery/write";
	}
	
	@RequestMapping("/portfolio/gallery/insert.do")
	public void insert(GalleryVo vo, HttpServletRequest req, HttpServletResponse res, MultipartFile file) throws Exception {
		// 등록처리
		//res.getWriter().print(GalleryService.insert(vo));
		
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
				String path = req.getRealPath("/upload/portfolio/gallery/");
				System.out.println(path);
				//path = "D:\\AI\\workspace\\pp\\src\\main\\webapp\\upload\\";
				file.transferTo(new File(path+filename));
				// 파일명을 vo에 저장
				vo.setImage(filename);
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		}
		
		res.setContentType("text/html;charset=utf-8");
		PrintWriter out = res.getWriter();
		out.print("<script>");
		if (GalleryService.insert(vo)) {
			out.print("alert('정상적으로 등록되었습니다.');");
			out.print("location.href='/pp/portfolio/gallery/index.do';");
		} else {
			out.print("alert('등록실패.');");
			out.print("history.back();");
		}
		out.print("</script>");
		out.flush();
	}
	
	
	@GetMapping("/portfolio/gallery/delete.do")
	public void delete(GalleryVo vo, HttpServletResponse res) throws IOException {
		res.getWriter().print(GalleryService.delete(vo));
	}
	
	@GetMapping("/portfolio/gallery/dogAjax.do")
	public String dogAjax(Model model, @RequestParam(required = false) String no, HttpServletRequest req, GalleryVo vo) {
//		System.out.println(no);
//		System.out.println(req.getParameter("no"));
//		System.out.println(vo.getNo());
		
		GalleryVo gvo = GalleryService.selectOne(vo, true);
		model.addAttribute("data", gvo);
		//req.setAttribute("data", vo);
		
		return "gallery/dogAjax";
	}
	
	@GetMapping("/portfolio/gallery/edit.do")
	public String edit(Model model, @RequestParam(required = false) String no, HttpServletRequest req, GalleryVo vo) {
		
		GalleryVo gvo = GalleryService.selectOne(vo, false);
		model.addAttribute("data", gvo);
		
		return "gallery/edit";
	}
	
	@RequestMapping("/portfolio/gallery/update.do")
	public void update(GalleryVo vo, HttpServletRequest req, HttpServletResponse res, MultipartFile file) throws Exception {
		// 등록처리
		//res.getWriter().print(GalleryService.insert(vo));
		
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
				String path = req.getRealPath("/upload/portfolio/gallery/");
				System.out.println(path);
				//path = "D:\\AI\\workspace\\pp\\src\\main\\webapp\\upload\\";
				file.transferTo(new File(path+filename));
				// 파일명을 vo에 저장
				vo.setImage(filename);
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		}
		
		res.setContentType("text/html;charset=utf-8");
		PrintWriter out = res.getWriter();
		out.print("<script>");
		if (GalleryService.update(vo)) {
			out.print("alert('정상적으로 수정되었습니다.');");
			out.print("location.href='/pp/portfolio/gallery/index.do';");
		} else {
			out.print("alert('등록실패.');");
			out.print("history.back();");
		}
		out.print("</script>");
		out.flush();
	}
	
	
	
	
}
