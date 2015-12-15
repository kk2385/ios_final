//
//  ViewController.m
//

#import "config.h"
#import "ViewController.h"
#import "GameController.h"
#import "HUDView.h"
#import "GameLayerView.h"

@interface ViewController () <UIActionSheetDelegate>
@property (strong, nonatomic) GameController* controller;
@end

@implementation ViewController

-(instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self != nil) {
        //create the game controller
        self.controller = [[GameController alloc] init];
    }
    return self;
}

//setup the view and instantiate the game controller
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //add one layer for all hud and controls
    HUDView* hudView = [HUDView viewWithRect:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:hudView];
    
    self.controller.hud = hudView;
    [self.controller.hud inMenuMode];
    
    //add one layer for all game elements
    GameLayerView* gameLayer = [[GameLayerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview: gameLayer];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
    self.controller.gameView = gameLayer;
}

//show tha game menu on app start
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

@end
