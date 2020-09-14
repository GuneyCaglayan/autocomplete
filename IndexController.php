<?php
namespace module\agency\controller;

use core\base\BaseController;

class IndexController extends BaseController
{

    private $autocompleteService;

    protected function init()
    {
        $this->autocompleteService = new AutoCompleteService();
    }

    public function handle()
    {
        $this->view->setViewName('index.form');

            $sales = $this->autocompleteService->getSalesForAgencyAccount(
                $agency,
                Config::get('remote', 'key'),
                ISaleService::PRODUCT_ALL,
                ISaleService::STATUS_AVAIL_SET,
                ISaleService::AUTOCOMPLETE_SALEID,
                $query,
                20);
            $this->putMap('sales', $sales);
    }
}
