package dendy.rpms.controller;

import dendy.rpms.domain.StudbookData;
import dendy.rpms.service.IAnimalStudbookService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * <p>Created by Dendy on 2014/9/21.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
@RequestMapping("/as")
@Controller
public class AnimalStudBookController {
    //~ Static fields/initializers =====================================================================================
    private static final Logger LOG = LoggerFactory.getLogger(AnimalStudBookController.class);

    //~ Instance fields ================================================================================================

    @Autowired
    private IAnimalStudbookService studbookService;

    //~ Methods ========================================================================================================

    @RequestMapping("/loadDown")
    @ResponseBody
    public StudbookData loadDown(Long animalId) {
        try {
            return studbookService.loadDown(animalId);
        } catch (Exception e) {
            LOG.error("load data exception : ", e);
            return new StudbookData();
        }
    }

    @RequestMapping("/loadUp")
    @ResponseBody
    public StudbookData loadUp(Long animalId) {
        try {
            return studbookService.loadUp(animalId);
        } catch (Exception e) {
            LOG.error("load data exception : ", e);
            return new StudbookData();
        }
    }
}
