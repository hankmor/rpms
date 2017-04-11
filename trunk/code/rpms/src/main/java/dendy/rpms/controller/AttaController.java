package dendy.rpms.controller;

import dendy.rpms.entity.Atta;
import dendy.rpms.message.BaseMessage;
import dendy.rpms.service.IAttaService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * <p>Created by Dendy on 2014/9/7.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
@Controller
@RequestMapping("/atta")
public class AttaController {
    //~ Static fields/initializers =====================================================================================
    private static final Logger LOG = LoggerFactory.getLogger(AttaController.class);

    //~ Instance fields ================================================================================================
    @Autowired
    private IAttaService attaService;

    //~ Methods ========================================================================================================

    @RequestMapping("/toUpdatePage")
    public String toUpdatePage(Long attaId, Model model) {
        Atta atta = attaService.get(attaId);
        model.addAttribute("atta", atta);
        return "/atta/update";
    }

    @RequestMapping("/update")
    @ResponseBody
    public BaseMessage update(Atta atta) {
        try {
            attaService.update(atta);
            return BaseMessage.successMessage("修改成功！");
        } catch (Exception e) {
            LOG.error("update atta failed :", e);
            return BaseMessage.errorMessage("修改失败，系统出现未知错误！");
        }
    }
}
