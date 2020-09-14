<?php
namespace service\sale\model;

use service\finance\model\MarkupExtensionRowMapper;

class SaleAutocompleteModelRowMapper extends MarkupExtensionRowMapper
{

    public function mapRow(array $row)
    {
        $id = $this->getInteger('id');
        $creationDate = $this->getTimestamp('creation_date');
        $productName = $this->getString('product_name');

        $autocomplete = new SaleAutocompleteModel();
        $autocomplete->setId($id);
        $autocomplete->setCreationDate($creationDate);
        $autocomplete->setProductName($productName);

        return $autocomplete;
    }
}
