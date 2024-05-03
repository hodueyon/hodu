package egovframework.fusion.lotto.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LottoController {
	
	@RequestMapping(value="/lotto/lottoSlot.do", method=RequestMethod.GET)
	public String LottoPage() {
		return "views/ihyeonLotto/lotto";

	}
}
