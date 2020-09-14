<?php
namespace service\sale\model;

class SaleHotelModel extends SaleModel
{

    private $id;

    private $productName;

    private $creationDate;

    public function getId()
    {
        return $this->id;
    }

    public function setId($id)
    {
        $this->id = $id;
    }

    public function getproductName()
    {
        return $this->productName;
    }

    public function setproductName($productName)
    {
        $this->productName = $productName;
    }

    public function getcreationDate()
    {
        return $this->creationDate;
    }

    public function setcreationDate($creationDate)
    {
        $this->creationDate = $creationDate;
    }
}
