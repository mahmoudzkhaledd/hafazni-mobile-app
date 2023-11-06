import 'package:hafazni/Models/AccountType.dart';

class AccountTypesApi {
  static Map<String, AccountTypeDescription> types = {
    "user": AccountTypeDescription(
      type: AccountTypeEnum.user,
      title: 'تفعيل ميزة اهدافك',
      content:
          'إن الهدف حين لا يكون واضحاً ومحدداً، فإنه لا يحفز صاحبه على العمل والعطاء وبذل الجهد. يكمن المجد في محاولة الشخص الوصول إلى هدف وليس عند الوصول إليه',
      conditions: [
        AccountTypeCondition(
          title: 'وضع هدف للحفظ',
          content:
              'هدف الحفظ هو وسيلة فعالة للاستمرار والتقدم ... وكما يساعدك هدف الحفظ في ترتيب اولوياتك ',
        ),
        AccountTypeCondition(
          title: 'وضع تارخ حفظك للقران (اختياري)',
          content:
              'وضع السور المحفوظة مسبقا يساعد المحفظين على معرفة حالة الطالب ويساعدهم في انشاء برنامج فعال يتماشى مع امكانيات الطالب',
        ),
      ],
    ),
    "memorizer": AccountTypeDescription(
      type: AccountTypeEnum.memorizer,
      title: "حساب محفظ",
      content:
          "يجب تفعيل حساب محفظ حتي تتمكن من الظهور في نتائج البحث وتلقي الطلبات من الطلاب .. بدون حساب محفظ يمكنك تصفح المنصة فقط دون عمل اي انشطة عليها",
      conditions: [
        AccountTypeCondition(
          title: "تفعيل المحفظة",
          content:
              "تفعيل المحفظة الالكترونية لكي يتم شحن وسحب الارباح من خلالها",
        ),
        AccountTypeCondition(
          title: 'رفع شهادات القراءة (اختياري)',
          content:
              'رفع شهادات القراءة او بمعنى اصح الاجازات يعطي انطباع للطالب عن مدى اهمية المحفظ ويساعده في اختيار المحفظ المناسب له',
        ),
        AccountTypeCondition(
          title: 'ضع وصفا لنفسك',
          content:
              'يساعد الوصف الطلاب على اختيار محفظ مناسب للعمل معه عند ارسال طلب تحفيظ',
        ),
        AccountTypeCondition(
          title: 'ضع القراءات التى تجيدها',
          content:
              'يساعد وضع القراءات الطلاب من مختلف الجنسيات على تحديد المحفظ المناسب لهم ارسال طلب تحفيظ',
        ),
      ],
    ),
  };
}
