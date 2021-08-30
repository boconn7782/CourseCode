#include <iostream>
#include <string>
using namespace std;
 
int main()
{
  char farm, again;
  int legs;
  // Required: Introduce the application
  // Required: Describe the program's purpose
  cout<<"*****************************************"<<endl;
  cout<<"       Not Quite Twenty Questions        " << endl;
  cout<<" For this game, you'll pick an item from " <<endl;
  cout<<" a list then answer questions about it.  " <<endl;
  cout<<" The program will try and guess which of " <<endl;
  cout<<" the items you selected. " <<endl;
  // Required: Welcomes the user
  cout<<"*****************************************"<<endl;
  cout<<"  Welcome player, Are you ready to play  " << endl;
  cout<<"      Not Quite Twenty Questions!?!      " <<endl;
  cout<<"*****************************************"<<endl<<endl;

  do
  {
    // Required: Ask the user to choose one item from a list
    cout<<"In your head, please choose an animal from the following list: "<<endl<<endl;
    cout<<"CHICKEN\tFISH \tFLAMINGO"<<endl;
    cout<<"LION   \tPIG  \t SNAIL"<<endl<<endl;
    system("pause");
    // Required: Ask a series of questions to guess the right option.
    // Minimum of TWO questions.
    cout<<"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"<<endl;
    cout<<"Does your animal live on a farm? (y/n) : ";
    cin>>farm;

    cout<<"How many legs does your animal have ? : ";
    cin>>legs;
    // Required: Must use at least one case switch  
    switch (legs)
    {
      case 0:
        if (farm=='y')
          cout<< "You picked the fish!"<<endl<<endl;
        else
          cout<< "You picked the snail"<<endl<<endl;
        break;
      
      case 2:
        if (farm=='y')
          cout<<"You picked the chicken!"<<endl<<endl;
        else
          cout<< "You picked the flamingo!"<<endl<<endl;
        break;
  
      case 4:
        if (farm=='y')
         cout<< "You picked the pig!"<<endl<<endl;
        else
          cout<< "You picked the lion!"<<endl<<endl;
        break;
      
      default:
        cout<<"I cannot guess, you stumped me (or picked something off the list)!"<<endl<<endl;
    }
    // Required: Ask player if they want to play again.
    cout<<"Do you want to play again? (y/n) : ";
    cin>>again;
    cout<<"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"<<endl;          
  } while (again=='y');      
  return 0;
}
