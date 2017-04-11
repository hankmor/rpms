package dendy.rpms.controller;

import dendy.rpms.domain.HouseTransferEntity;
import dendy.rpms.entity.HouseTransfer;
import dendy.rpms.message.BaseMessage;
import dendy.rpms.service.IHouseTransferService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * 圈舍转移信息
 *
 * @author Dendy
 * @since 14-2-20
 */
@Controller
@RequestMapping("/ht")
public class HouseTransferController {
    private static final Logger LOG = LoggerFactory.getLogger(HouseTransferController.class);
    @Autowired
    private IHouseTransferService houseTransferService;

    @RequestMapping(value = "/init", method = RequestMethod.POST)
    public String toMemberPage() {
        return "/transfer/transfer";
    }

    @RequestMapping(value = "/toOutOtherZoo", method = RequestMethod.POST)
    public String toOutOtherZoo() {
        return "/transfer/outOtherZoo";
    }

    @RequestMapping(value = "/toOutOtherHouse", method = RequestMethod.POST)
    public String toOutOtherHouse() {
        return "/transfer/outOtherHouse";
    }

    @RequestMapping("/transOutToZoo")
    @ResponseBody
    public BaseMessage transOutToOtherZoo(String ids, HouseTransfer houseTransfer) {
        try {
            houseTransferService.transOutToZoo(ids, houseTransfer);
            return BaseMessage.successMessage("操作成功！");
        } catch (Exception e) {
            LOG.error("trans out to other zoo failed : ", e);
        }
        return BaseMessage.errorMessage("操作失败，系统出现未知错误！");
    }

    @RequestMapping("/transOutToHouse")
    @ResponseBody
    public BaseMessage transOutToLocalHouse(String ids, HouseTransfer houseTransfer) {
        try {
            houseTransferService.transOutToLocal(ids, houseTransfer);
            return BaseMessage.successMessage("操作成功！");
        } catch (Exception e) {
            LOG.error("trans out to other zoo failed : ", e);
        }
        return BaseMessage.errorMessage("操作失败，系统出现未知错误！");
    }

    @RequestMapping("toTransRecords")
    public String toTransRecordsPage() {
        return "/transfer/history";
    }

    @RequestMapping("transRecords")
    @ResponseBody
    public List<HouseTransferEntity> transRecords(Long id) {
        try {
            return houseTransferService.getTransRecords(id);
        } catch (Exception e) {
            LOG.error("get trans out records failed : ", e);
        }
        return new ArrayList<>();
    }
}
