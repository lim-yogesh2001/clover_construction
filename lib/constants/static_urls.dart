
const domain = "http://10.0.2.2:8000";

const storeApi = domain + "/store-api/";
const storeList = storeApi + "store-list/";
const storeCategoriesUrl = "${storeApi}store-categories";

const productApi = "$domain/products-api/";
const productListApi = "${productApi}products-list/";

const departmentsApi = "$domain/departments-api/";

const workerApi = "$domain/departments-api/";
const workerList = "${workerApi}worker-list/";

const userApi = "$domain/user-api/";
const userRegister = "${userApi}user-register/";
const userLogin = "${userApi}user-login/";

const hireAndorderApi = "$domain/hireAndOrder-api/";
const orderListUrl = "${hireAndorderApi}orders-list";
const hireList = "${hireAndorderApi}hire-woker";