package dendy.rpms.controller;

import dendy.rpms.domain.HouseEntity;
import dendy.rpms.entity.House;
import dendy.rpms.message.BaseMessage;
import dendy.rpms.page.Pager;
import dendy.rpms.query.HouseQuery;
import dendy.rpms.service.IHouseService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 圈舍信息
 *
 * @author Dendy
 * @since 14-2-20
 */
@Controller
@RequestMapping("/house")
public class HouseController {
    private static final Logger LOG = LoggerFactory.getLogger(HouseController.class);
    @Autowired
    private IHouseService houseService;

    @RequestMapping(value = "/init", method = RequestMethod.POST)
    public String init() {
        return "/house/house";
    }

    @RequestMapping(value = "/toUpdatePage", method = RequestMethod.POST)
    public String toUpdatePage() {
        return "/house/update";
    }

    @RequestMapping(value = "/toAddPage", method = RequestMethod.POST)
    public String toAddPage() {
        return "/house/add";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage update(House house) {
        try {
            houseService.update(house);
            return BaseMessage.successMessage("修改成功！");
        } catch (Exception e) {
            LOG.error("update house error :", e);
            return BaseMessage.errorMessage("修改失败，请稍后重试!");
        }
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage add(House house) {
        try {
            houseService.add(house);
            return BaseMessage.successMessage("添加成功！");
        } catch (Exception e) {
            LOG.error("add house error : ", e);
            return BaseMessage.errorMessage("添加失败，请稍后重试!");
        }
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public BaseMessage delete(String ids) {
        try {
            houseService.delete(ids);
            return BaseMessage.successMessage("删除成功！");
        } catch (Exception e) {
            LOG.error("delete house error : ", e);
            return BaseMessage.errorMessage("删除失败，请稍后重试!");
        }
    }

    /**
     * 查询圈舍信息
     *
     * @param houseQuery 查询表单
     * @return 分页对象
     */
    @RequestMapping(value = "/pager", method = RequestMethod.POST)
    @ResponseBody
    public Pager<HouseEntity> pager(HouseQuery houseQuery) {
        try {
            return houseService.page(houseQuery);
        } catch (Exception e) {
            LOG.error("Query houses has exception : ", e);
            return new Pager<>(0);
        }
    }

    @RequestMapping(value = "/same", method = RequestMethod.POST)
    @ResponseBody
    public boolean checkSameNo(String no) {
        try {
            House house = houseService.getByNo(no);
            if (house != null)
                return true;
            return false;
        } catch (Exception e) {
            LOG.error("check house same number has exception : ", e);
            return true;
        }
    }
}
