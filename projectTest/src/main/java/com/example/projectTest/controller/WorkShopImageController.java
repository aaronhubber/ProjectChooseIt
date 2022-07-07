package com.example.projectTest.controller;

import com.example.projectTest.model.WorkShopImage;
import com.example.projectTest.service.WorkShopImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin(origins = "*")
public class WorkShopImageController {

    @Autowired
    WorkShopImageService workShopImageService;

    @RequestMapping(value= "getallworkshopimages", method = RequestMethod.GET)
    public List<WorkShopImage> getAllWorkShopImages(){
        return workShopImageService.getAllWorkShopImages();
    }

    @RequestMapping(value = "addworkshopimage", method = RequestMethod.POST)
    public String addWorkShopImage(@RequestBody WorkShopImage workShopImage){
        return workShopImageService.addWorkShopImage(workShopImage);
    }

    @RequestMapping(value = "updateworkshopimage", method = RequestMethod.PUT)
    public String updateWorkShopImage(@RequestBody WorkShopImage workShopImage){
        return workShopImageService.updateWorkShopImage(workShopImage);
    }

    @RequestMapping(value = "removeworkshopimage", method = RequestMethod.DELETE)
    public String removeWorkShopImage(@RequestBody WorkShopImage workShopImage){
        return workShopImageService.removeWorkShopImage(workShopImage);
    }

}
