//
//  ViewController.m
//  MicroblogDemo
//
//  Created by Sky on 15/3/26.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "ViewController.h"
#import "Test2TableViewCell.h"

static NSString *CellIdentifier = @"CellIdentifier";


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


// A dictionary of offscreen cells that are used within the tableView:heightForRowAtIndexPath: method to
// handle the height calculations. These are never drawn onscreen. The dictionary is in the format:
//      { NSString *reuseIdentifier : UITableViewCell *offscreenCell, ... }
@property (strong, nonatomic) NSMutableDictionary *offscreenCells;


@property(nonatomic,strong)UITableView* testTableView;


@property(nonatomic,strong)NSArray*  tableData;

@property(nonatomic,strong)NSArray*  urlArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setTitle:@"SkyBlog"];
    
    [self.view addSubview:self.testTableView];
    
    self.offscreenCells = [NSMutableDictionary dictionary];
    
    [self.testTableView registerClass:[Test2TableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    
    // self.testTableView.estimatedRowHeight = UITableViewAutomaticDimension;
    
    self.testTableView.allowsSelection = NO;
    
    self.tableData = @[
                       @" 中国网3月26日讯 据外媒报道，当地时间3月25日，法国总统奥朗德，德国总理默克尔、西班牙首相拉霍伊共同抵达德国之翼航空公司客机的失事地点。报道称，三位国家领导人抵达当地以后，与参加搜救的工作人员在临时指挥中心进行了会面。此外，法、德、西三国领导人在客机坠毁地点附近对在此次空难中的遇难者表示哀悼，并对参与搜救的消防队员表示了感谢。",
                       @"大量的文物流失，频频的文物破坏已成为中国文物保护工作的常年之痛。中国文物保护立法已经30多年，今天，除了相关部门对文物保护的漠视和不作为，我们剩下的只有那些越来越少的沉默的文物。",
                       @"当地时间2015年3月25日，乌克兰基辅，在记者、摄影师及一众高官的注视之下，乌克兰警方冲入一场电视转播的内阁会议现场，逮捕乌克兰紧急服务部部长Serhiy Bochkovsky及其副手Vasyl Stoyetsky，两人均被控“高层次”腐败。据乌克兰内政部长表示，被捕的两人涉嫌多付给包括俄罗斯石油巨头卢克石油公司在内的多家公司采购费用。",
                       @"四川峨眉山景区降近7年来最大雪",
                       @"萌物：伊犁鼠兔是世界珍稀动物之一。日前，这一天然萌物再次在中国新疆被发现。伊犁鼠兔，生活在天山山脉高寒山区，是中国新疆特有的一个物种。3月23日，实名认证微博“美国国家地理”发布一组有关伊犁鼠兔的照片，因其形象呆萌可爱，长相酷似泰迪，立即引起了众多网友的关注。23日中午，记者电话联系到新疆发现鼠兔第一人，新疆环境保护科学研究院副研究员、新疆生态学会副秘书长李维东，他义务跟踪保护鼠兔三十多年。李维东介绍，美国国家地理微博晒出的这组鼠兔照片，是他去年7月在天山精河县木孜克冰达坂布设红外线触发相机时摄到的。照片中的鼠兔，也是他时隔24年后再次拍摄到的珍贵镜头。"
                       ];
    
    _urlArray= @[@"http://ww2.sinaimg.cn/thumbnail/904c2a35jw1emu3ec7kf8j20c10epjsn.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/67307b53jw1epqq3bmwr6j20c80axmy5.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/9ecab84ejw1emgd5nd6eaj20c80c8q4a.jpg",
                        @"http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif",
                        @"http://ww4.sinaimg.cn/thumbnail/9e9cb0c9jw1ep7nlyu8waj20c80kptae.jpg"];

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Test2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.userNameLabel.text=@"真相只有一个";
    cell.timeLabel.text=@"1个小时前";
    cell.bodyLabel.text = [self.tableData objectAtIndex:indexPath.row];
    cell.headImageView.image=[UIImage imageNamed:@"headImg_4"];
    
    
    [cell setImageswithURLs:_urlArray];
   // [cell setImageswithURLs:@[@"headImg_1",@"headImg_2",@"headImg_3",@"headImg_4",@"headImg_5",@"headImg_6",@"headImg_7",@"headImg_8",@"headImg_9"]];
    //[cell setImageswithURLs:@[@"headImg_1",@"headImg_2",@"headImg_3"]];
    //[cell setImageswithURLs:@[@"headImg_1"]];


    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    Test2TableViewCell *cell = [self.testTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    if (!cell)
    //    {
    //        cell=[[Test2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //    }
    //    cell.translatesAutoresizingMaskIntoConstraints = NO;
    //    cell.bodyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //    cell.headImageView.translatesAutoresizingMaskIntoConstraints = NO;
    //    cell.bodyLabel.text = [self.tableData objectAtIndex:indexPath.row];
    //    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    //    NSLog(@"h=%f", size.height + 1);
    //    return 1  + size.height;
    // This project has only one cell identifier, but if you are have more than one, this is the time
    // to figure out which reuse identifier should be used for the cell at this index path.
    NSString *reuseIdentifier = CellIdentifier;
    
    // Use the dictionary of offscreen cells to get a cell for the reuse identifier, creating a cell and storing
    // it in the dictionary if one hasn't already been added for the reuse identifier.
    // WARNING: Don't call the table view's dequeueReusableCellWithIdentifier: method here because this will result
    // in a memory leak as the cell is created but never returned from the tableView:cellForRowAtIndexPath: method!
    Test2TableViewCell *cell = [self.offscreenCells objectForKey:reuseIdentifier];
    if (!cell) {
        cell = [[Test2TableViewCell alloc] init];
        [self.offscreenCells setObject:cell forKey:reuseIdentifier];
    }
    
    // Configure the cell for this indexPath
    //[cell updateFonts];
    //NSDictionary *dataSourceItem = [self.model.dataSource objectAtIndex:indexPath.row];
    //cell.titleLabel.text =  [dataSourceItem valueForKey:@"title"];
    cell.userNameLabel.text=@"真相只有一个";
    cell.timeLabel.text=@"1个小时前";
    cell.bodyLabel.text = [self.tableData objectAtIndex:indexPath.row];
    cell.headImageView.image=[UIImage imageNamed:@"headImg_4"];
    
    /**
     *  添加多图
     */
    
    
    [cell setImageswithURLs:_urlArray];

    //[cell setImageswithURLs:@[@"headImg_1",@"headImg_2",@"headImg_3",@"headImg_4",@"headImg_5",@"headImg_6",@"headImg_7",@"headImg_8",@"headImg_9"]];
   // [cell setImageswithURLs:@[@"headImg_1",@"headImg_2",@"headImg_3"]];
    //[cell setImageswithURLs:@[@"headImg_1"]];
    
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    // The cell's width must be set to the same size it will end up at once it is in the table view.
    // This is important so that we'll get the correct height for different table view widths, since our cell's
    // height depends on its width due to the multi-line UILabel word wrapping. Don't need to do this above in
    // -[tableView:cellForRowAtIndexPath:] because it happens automatically when the cell is used in the table view.
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    // NOTE: if you are displaying a section index (e.g. alphabet along the right side of the table view), or
    // if you are using a grouped table view style where cells have insets to the edges of the table view,
    // you'll need to adjust the cell.bounds.size.width to be smaller than the full width of the table view we just
    // set it to above. See http://stackoverflow.com/questions/3647242 for discussion on the section index width.
    
    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints
    // (Note that the preferredMaxLayoutWidth is set on multi-line UILabels inside the -[layoutSubviews] method
    // in the UITableViewCell subclass
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    // Get the actual height required for the cell
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    // Add an extra point to the height to account for the cell separator, which is added between the bottom
    // of the cell's contentView and the bottom of the table view cell.
    height += 1;
    
    //NSLog(@"height:%f",height);
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}




-(UITableView *)testTableView
{
    if (!_testTableView)
    {
        _testTableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _testTableView.delegate=self;
        _testTableView.dataSource=self;
    }
    return _testTableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
