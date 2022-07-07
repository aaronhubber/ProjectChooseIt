package com.example.projectTest.service;

import com.example.projectTest.model.WorkShopImage;
import com.example.projectTest.repository.WorkShopImagesRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class WorkShopImageService {

    @Autowired
    WorkShopImagesRepository workShopImagesRepository;

    public List<WorkShopImage> getAllWorkShopImages(){
        try{
            List<WorkShopImage> workShopImages = workShopImagesRepository.findAll();
            List<WorkShopImage> customImages = new ArrayList<>();
            workShopImages.stream().forEach(e ->{
                WorkShopImage workShopImage = new WorkShopImage();
                BeanUtils.copyProperties(e, workShopImage);
                customImages.add(workShopImage);
            });
            return customImages;
        }catch(Exception e){
            throw e;
        }
    }

    public String addWorkShopImage(WorkShopImage workShopImage) {
        try {
            workShopImagesRepository.save(workShopImage);
            return "That's it added";
        } catch (Exception e) {
            throw e;
        }
    }

    public String removeWorkShopImage(WorkShopImage workShopImage){
        try{
            workShopImagesRepository.delete(workShopImage);
            return "That it gone";
        }catch (Exception e) {
            throw e;
    }
    }
    public String updateWorkShopImage(WorkShopImage workShopImage){
        try{
            workShopImagesRepository.save(workShopImage);
            return "That it updated";
        }catch (Exception e) {
            throw e;
        }
    }
    }







