
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/model/FaqsModel/FaqsResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class FaqsController extends GetxController {
  Repo repo = Repo(WebService());
  var faqsResponse = FaqsResponse().obs;
  RxList<dynamic> faqList=[].obs;
  RxList<dynamic> faqList2=[].obs;
  // RxList<Faqs> faqsubList=[].obs ;
  var isLoading = false.obs;
  //List<Faqs>? sub;

  getFaqs()async{
    isLoading.value=true;
    faqsResponse.value = await repo.faqs("client");
    if(faqsResponse.value.success==true){
      isLoading.value=false;
      faqList.value=faqsResponse.value.data as List;
      for (var faq in faqsResponse.value.data!) {
        print('Question: ${faq.name}');
        for (var subFaq in faq.faqs!) {
          print('Sub-Question: ${subFaq.question}');
          print('Answer: ${subFaq.answer}');
           //sub=faq.faqs!;
           //update();
      }
    }}
    return faqsResponse.value;
  }
}