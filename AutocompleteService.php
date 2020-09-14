<?php
namespace service\agency;

use core\implement\IDB;
use core\service\DatabaseService;
use core\service\PreparedStatement;
use service\autocomplete\model\SaleAutocompleteModelRowMapper;

class AgencyService extends DatabaseService
{

    private $autocomplete;

    public function __construct()
    {
        parent::__construct();

     $this->autocomplete = new PreparedStatement(
            'ADMIN_SALE_getSalesByAutocompleteQuery',
            new SaleAutocompleteModelRowMapper(),
            IDB::TYPE_INTEGER,
            IDB::TYPE_STRING,
            IDB::TYPE_STRING,
            IDB::TYPE_STRING,
            IDB::TYPE_STRING,
            IDB::TYPE_STRING,
            IDB::TYPE_INTEGER);
    }
    public function autocomplete(AgencyModel $agency, $appKey, $productType, $status, $option, $query, $count)
    {
        $result = $this->call(
            $this->autocomplete,
            $agency->getId(), //agencyId
            $appKey, //key
            $productType, //'flight, hotel, tour, package, transfer, car'
            $status, //'book, cancel, cancelpanding'
            $option, //'saleId'
            $query,
            $count);
        return $result;
    }
}




