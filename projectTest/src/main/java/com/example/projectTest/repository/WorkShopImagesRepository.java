package com.example.projectTest.repository;

import com.example.projectTest.model.WorkShopImage;
import org.springframework.data.domain.Example;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface WorkShopImagesRepository extends JpaRepository<WorkShopImage, Long> {

}
