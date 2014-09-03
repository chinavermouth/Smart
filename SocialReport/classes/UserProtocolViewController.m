//
//  UserProtocolViewController.m
//  SocialReport
//
//  Created by J.H on 14-6-12.
//  Copyright (c) 2014年 HuXiaoBin. All rights reserved.
//

#import "UserProtocolViewController.h"

@interface UserProtocolViewController ()

@end

@implementation UserProtocolViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"用户协议";
    }
    return self;
}

- (void)initView
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 关于物业云" style:UIBarButtonItemStylePlain target:self action:@selector(backFunc)];
    
    CGRect frame = self.view.frame;
    frame.size.height += 44;
//    // bgScrollView
//    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
//    {
//        frame.origin.y = 0;
//        frame.size.height -= self.navigationController.navigationBar.bounds.size.height;
//    }
    bgScrollView = [[UIScrollView alloc]initWithFrame:frame];
    bgScrollView.directionalLockEnabled = YES;
    bgScrollView.pagingEnabled = NO;
    bgScrollView.showsVerticalScrollIndicator = YES;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    bgScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    bgScrollView.contentSize = CGSizeMake(320, 568*9.75);
    [self.view addSubview:bgScrollView];

    frame.origin.x = 8;
    frame.size.width -= 2*8;
    frame.size.height = 568*9.75;
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:frame];
    contentLbl.numberOfLines = 0;
    contentLbl.text = @"乐居网www.pmsaas.net(以下简称pmsaas)所提供的各项服务的所有权和运作权均归厦门领航科技有限公司（以下简称'领航'）所有。www.pmsaas.cn用户使用协议（以下简称'本协议'）系由www.pmsaas.cn用户与领航就www.pmsaas.cn的各项服务所订立的相关权利义务规范。用户通过访问和/或使用本网站，即表示接受并同意本协议的所有条件和条款。领航作为pmsaas（www.pmsaas.cn）的运营者依据本协议为用户提供服务。不愿接受本协议条款的，不得访问或使用本网站。pmsaas有权对本协议条款进行修改，修改后的协议一旦公布即有效代替原来的协议。用户可随时查阅最新协议。\n《知识产权声明》及《商户收录声明》为本协议不可分割的组成部分。\n用户参与pmsaas团购时，还须同意及遵守相关团购规则。\n\n一、服务内容\n1、pmsaas运用自己的系统，通过互联网络等方式为用户提供各种信息包括并不限于（商户信息、点评信息、消费信息、优惠信息、团购等）网络服务。\n2、用户必须自行准备如下设备和承担如下开支：\n（1）上网设备，包括并不限于电脑或者其他上网终端、调制解调器及其他上网装置；\n（2）上网开支，包括并不限于网络接入费、上网设备租用费、手机流量费等。\n3、用户提供的注册资料，用户同意：\n（1）提供合法、真实、准确、详尽的个人资料；\n（2）如有变动，及时更新用户资料。\n如果用户提供的注册资料不合法、不真实、不准确、不详尽的，用户需承担因此引起的相应责任及后果，并且pmsaas保留终止用户使用pmsaas各项服务的权利。\n二、服务的提供、修改及终止\n1、用户在接受pmsaas各项服务的同时，同意接受pmsaas提供的各类信息服务。用户在此授权pmsaas可以向其电子邮件、手机、通信地址等发送商业信息。用户有权选择不接受pmsaas提供的各类信息服务，并进入pmsaas相关页面进行更改。\n2、pmsaas保留随时修改或中断服务而不需通知用户的权利。pmsaas有权行使修改或中断服务的权利，不需对用户或任何无直接关系的第三方负责。\n3、用户对本协议的修改有异议，或对pmsaas的服务不满，可以行使如下权利：\n（1）停止使用pmsaas的网络服务；\n（2）通过客服等渠道告知pmsaas停止对其服务。 结束服务后，用户使用pmsaas络服务的权利立即终止。\n在此情况下，pmsaas没有义务传送任何未处理的信息或未完成的服务给用户或任何无直接关系的第三方。\n三、用户信息的保密\n1、本协议所称之pmsaas用户信息是指符合法律、法规及相关规定，并符合下述范围的信息：\n（2）用户在使用pmsaas服务、参加网站活动或访问网站网页时，pmsaas自动接收并记录的用户浏览器端或手机客户端数据，包括但不限于IP地址、网站Cookie中的资料及用户要求取用的网页记录；\n（3）pmsaas从商业伙伴处合法获取的用户个人信息；\n（4）其它pmsaas通过合法途径获取的用户个人信息。\n2、pmsaas承诺：\n非经法定原因或用户事先许可，pmsaas不会向任何第三方透露用户的密码、姓名、手机号码等非公开信息\n3、在下述法定情况下，用户的个人信息将会被部分或全部披露：\n（1）经用户同意向用户本人或其他第三方披露；\n（2）根据法律、法规等相关规定，或行政机构要求，向行政、司法机构或其他法律规定的第三方披露；\n（3）其它pmsaas根据法律、法规等相关规定进行的披露。\n四、用户权利\n1、用户的用户名、密码和安全性\n（1）用户有权选择是否成为pmsaas会员，用户选择成为pmsaas注册用户的，可自行创建、修改昵称。用户名和昵称的命名及使用应遵守相关法律法规并符合网络道德。用户名和昵称中不能含有任何侮辱、威胁、淫秽、谩骂等侵害他人合法权益的文字。\n（2）用户一旦注册成功，成为pmsaas的会员，将得到用户名（用户邮箱）和密码，并对以此组用户名和密码登入系统后所发生的所有活动和事件负责，自行承担一切使用该用户名的言语、行为等而直接或者间接导致的法律责任。\n（3）用户有义务妥善保管pmsaas账号、用户名和密码，用户将对用户名和密码安全负全部责任。因用户原因导致用户名或密码泄露而造成的任何法律后果由用户本人负责。\n（4）用户密码遗失的，可以通过注册电子邮箱发送的链接重置密码，以手机号码注册的用户可以凭借手机号码找回原密码。用户若发现任何非法使用用户名或存在其他安全漏洞的情况，应立即告知pmsaas。\n2、用户有权在注册并登陆后对站内发布客观、真实、亲身体验的信息和图片；\n3、 用户有权在注册并登陆后自行添加商户、完善站内商户的各种信息；\n4、用户有权根据网站相关规定，在发布点评信息等贡献后，可能取得pmsaas给予的奖励（如贡献值等）；\n5、用户有权修改其个人账户中各项可修改信息，自行选择昵称和录入介绍性文字，自行决定是否提供非必填项的内容；\n6、用户有权参加pmsaas社区，并发表符合国家法律规定，并符合pmsaas社区规则的文章及观点；\n7、用户有权根据网站相关规定，获得pmsaas给与的奖励（如贡献值等）；\n8、用户有权参加pmsaas组织提供的各项线上、线下活动；\n9、用户有权在pmsaas上自行浏览、下载和使用优惠券。\n10、用户有权下载安装pmsaas手机客户端并使用其功能。\n11、用户有权根据相关团购规则，参加pmsaas团购；\n12、用户有权根据pmsaas网站规定，享受pmsaas提供的其它各类服务。\n五、用户义务\n1、不得利用本站危害国家安全、泄露国家秘密，不得侵犯国家社会集体的和公民的合法权益，不得利用本站制作、复制和传播下列信息：\n（1）煽动抗拒、破坏宪法和法律、行政法规实施的；\n（2）煽动颠覆国家政权，推翻社会主义制度的；\n（3）煽动分裂国家、破坏国家统一的；\n（4）煽动民族仇恨、民族歧视，破坏民族团结的；\n（5）捏造或者歪曲事实，散布谣言，扰乱社会秩序的；\n（6）宣扬封建迷信、淫秽、色情、赌博、暴力、凶杀、恐怖、教唆犯罪的；\n（7）公然侮辱他人或者捏造事实诽谤他人的，或者进行其他恶意攻击的；\n（8）损害国家机关信誉的；\n（9）其他违反宪法和法律行政法规的；\n（10）进行商业广告行为的。\n2、用户不得通过任何手段恶意注册pmsaas站帐号，包括但不限于以牟利、炒作、套现、获奖等为目的多个账号注册。用户亦不得盗用其他用户帐号。如用户违反上述规定，则pmsaas有权直接采取一切必要的措施，包括但不限于删除用户发布的内容、取消用户在网站获得的各种荣誉以及虚拟财富，暂停或查封用户帐号，取消因违规所获利益，乃至通过诉讼形式追究用户法律责任等。\n3、用户需维护点评的客观、真实性，不得利用pmsaas用户身份进行违反诚信的任何行为，包括但不限于：炒作商户，并向商户收取费用或获取利益；为获得利益或好处，参与或组织撰写及发布虚假点评；以差评威胁，要求商户提供额外的利益或好处；进行其他其它影响点评真实性、客观性、干扰扰乱网站正常秩序的违规行为等。如用户违反上述规定，则pmsaas有权采取一切必要的措施，包括但不限于：删除用户发布的内容、取消用户在网站获得的荣誉以及虚拟财富，暂停或查封用户帐号，取消因违规所获利益，乃至通过诉讼形式追究用户法律责任等。\n4、禁止用户将pmsaas以任何形式作为从事各种非法活动的场所、平台或媒介。未经pmsaas的授权或许可，用户不得借用本站的名义从事任何商业活动，也不得以任何形式将pmsaas作为从事商业活动的场所、平台或媒介。如用户违反上述规定，则pmsaas有权直接采取一切必要的措施，包括但不限于删除用户发布的内容、取消用户在网站获得的荣誉以及虚拟财富，暂停或查封用户帐号，取消因违规所获利益，乃至通过诉讼形式追究用户法律责任等。\n5、用户在pmsaas以各种形式发布的一切信息，均应符合国家法律法规等相关规定及网站相关规定，符合社会公序良俗，并不侵犯任何第三方主体的合法权益，否则用户自行承担因此产生的一切法律后果，且pmsaas因此受到的损失，有权向用户追偿。\n六、知识产权及其它权利\n1、用户已经明确阅读，并明确了解本网站的《知识产权声明》。\n2、任何用户接受本协议，即表明该用户主动将其在任何时间段在本站发表的任何形式的信息的著作财产权，包括并不限于：复制权、发行权、出租权、展览权、表演权、放映权、广播权、信息网络传播权、摄制权、改编权、翻译权、汇编权等，以及应当由著作权人享有的其他可转让权利无偿独家转让给pmsaas运营商所有，同时表明该用户许可pmsaas有权利就任何主体侵权而单独提起诉讼，并获得全部赔偿。 本协议已经构成《著作权法》第二十五条所规定的书面协议，其效力及于用户在pmsaas发布的任何受著作权法保护的作品内容，无论该内容形成于本协议签订前还是本协议签订后。\n3、领航是pmsaas的制作者,拥有此网站内容及资源的版权,受国家知识产权保护,享有对本网站各种协议、声明的修改权；未经pmsaas的明确书面许可，任何第三方不得为任何非私人或商业目的获取或使用本网站的任何部分或通过本网站可直接或间接获得的任何内容、服务或资料。任何第三方违反本协议的规定以任何方式，和/或以任何文字对本网站的任何部分进行发表、复制、转载、更改、引用、链接、下载或以其他方式进行使用，或向任何其他第三方提供获取本网站任何内容的渠道，则对本网站的使用权将立即终止，且任何第三方必须按照本公司的要求，归还或销毁使用本网站任何部分的内容所创建的资料的任何副本。\n4、pmsaas未向任何第三方转让本网站或其中的任何内容所相关的任何权益或所有权，且一切未明确向任何第三方授予的权利均归pmsaas所有。未经本协议明确允许而擅自使用本网站任何内容、服务或资料的，构成对本协议的违约行为，且可能触犯著作权、商标、专利和/或其他方面的法律法规，pmsaas保留对任何违反本协议规定的第三方（包括单位或个人等）提起法律诉讼的权利。\n5、本公司可按自身判断随时对本协议进行修改及更新。对本协议的所有改动一经发布即产生法律效力，并适用于改动发布后对本网站的一切访问和使用行为。如用户在修改后的本协议发布后继续使用本网站的，即代表用户接受并同意了这些改动。用户应定期查看本网页，了解对用户具有约束力的本协议的任何改动。\n七、拒绝担保与免责\n1、pmsaas作为“网络服务提供者”的第三方平台，不担保网站平台上的信息及服务能充分满足用户的需求。对于用户在接受pmsaas的服务过程中可能遇到的错误、侮辱、诽谤、不作为、淫秽、色情或亵渎事件，pmsaas不承担法律责任。\n2、基于互联网的特殊性，pmsaas也不担保服务不会受中断，对服务的及时性、安全性都不作担保，不承担非因pmsaas导致的责任。\npmsaas力图使用户能对本网站进行安全访问和使用，但pmsaas不声明也不保证本网站或其服务器是不含病毒或其它潜在有害因素的；因此用户应使用业界公认的软件查杀任何自pmsaas下载文件中的病毒。\n3、pmsaas不对用户所发布信息的保存、修改、删除或储存失败负责。对网站上的非因pmsaas故意所导致的排字错误、疏忽等不承担责任。pmsaas有权但无义务，改善或更正本网站任何部分之疏漏、错误。\n4、除非pmsaas以书面形式明确约定，pmsaas对于用户以任何方式（包括但不限于包含、经由、连接或下载）从本网站所获得的任何内容信息，包括但不限于广告、商户信息、点评内容等，不保证其准确性、完整性、可靠性；对于用户因本网站上的内容信息而购买、获取的任何产品、服务、信息或资料，pmsaas不承担责任。用户自行承担使用本网站信息内容所导致的风险。\n5、pmsaas内所有用户所发表的用户点评，仅代表用户个人观点，并不表示本网站赞同其观点或证实其描述，本网站不承担用户点评引发的任何法律责任。\n6、pmsaas有权删除pmsaas站内各类不符合法律或协议规定的点评，而保留不通知用户的权利。\n7、所有发给用户的通告，pmsaas都将通过正式的页面公告、站内信、电子邮件、客服电话、手机短信或常规的信件送达。任何非经pmsaas正规渠道获得的中奖、优惠等活动或信息，pmsaas不承担法律责任。\n八、侵权投诉\n1、据《中华人民共和国侵权责任法》第三十六条，任何第三方认为，用户利用pmsaas平台侵害本人民事权益或实施侵权行为的，包括但不限于侮辱、诽谤等，被侵权人有权书面通知pmsaas采取删除、屏蔽、断开链接等必要措施。\n2、据《信息网络传播权保护条例》，任何第三方认为，pmsaas所涉及的作品、表演、录音录像制品，侵犯自己的信息网络传播权或者被删除、改变了自己的权利管理电子信息的，可以向pmsaas提交书面通知，要求pmsaas删除该侵权作品，或者断开链接。通知书应当包含下列内容：\n（一）权利人的姓名（名称）、联系方式和地址；\n（二）要求删除或者断开链接的侵权作品、表演、录音录像制品的名称和网络地址；\n（三）构成侵权的初步证明材料。权利人应当对通知书的真实性负责。此外，为使pmsaas能及时、准确作出判断，还请侵权投诉人一并提供以下材料：\n3、任何第三方（包括但不限于企业、公司、单位或个人等）认为pmsaas用户发布的任何信息侵犯其合法权益的，包括但不限于以上两点，在有充分法律法规及证据足以证明的情况下，均可以通过下列联系方式通知pmsaas：\n邮寄地址：厦门软件园二期望海路15号402\n邮政编码：361008\n收件人：pmsaas客服部\n客服电话：0592-5807033\n客服信箱：kefu@pmsaas.com\n4、侵权投诉必须包含下述信息：\n（1）被侵权人的证明材料，或被侵权作品的原始链接及其它证明材料。\n（2）侵权信息或作品在pmsaas上的具体链接。\n（3）侵权投诉人的联络方式，以便pmsaas相关部门能及时回复您的投诉，最好包括电子邮件地址、电话号码或手机等。\n（4）投诉内容须纳入以下声明：“本人本着诚信原则，有证据认为该对象侵害本人或他人的合法权益。本人承诺投诉全部信息真实、准确，否则自愿承担一切后果。\n（5）本人亲笔签字并注明日期，如代理他人投诉的，必须出具授权人签字的授权书。\n5、pmsaas建议用户在提起投诉之前咨询法律顾问或律师。我们提请用户注意：如果对侵权投诉不实，则用户可能承担法律责任。\n九、适用法律和裁判地点\n1、因用户使用pmsaas站而引起或与之相关的一切争议、权利主张或其它事项，均受中华人民共和国法律的管辖。\n2、用户和pmsaas发生争议的，应首先本着诚信原则通过协商加以解决。如果协商不成，则应向pmsaas所在地人民法院提起诉讼。\n十、可分性\n如果本协议的任何条款被视为不合法、无效或因任何原因而无法执行，则此等规定应视为可分割，不影响任何其它条款的法律效力。\n十一、冲突选择\n本协议是pmsaas与用户注册成为pmsaas用户，使用pmsaas服务之间的重要法律文件，pmsaas或者用户的任何其他书面或者口头意思表示与本协议不一致的，均应当以本协议为准。\n";
    contentLbl.font = [UIFont systemFontOfSize:14.0f];
    contentLbl.textColor = [UIColor blackColor];
    contentLbl.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:contentLbl];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backFunc
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
