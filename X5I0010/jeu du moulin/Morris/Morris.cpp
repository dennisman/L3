// Morris.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "board.h"
#include "move.h"
#include "gamecontroller.h"
using namespace std;

int _tmain(int argc, _TCHAR* argv[])
{
	if (argc > 1) {
		if (argv[1][0] == 't') {
			GameController *game = new GameController(atoi(argv[2]), 10, true);
			delete game;
		}
		else {
			GameController *game = new GameController(atoi(argv[2]), 10, false);
			delete game;
		}
	}
	else {
		int timel;
		char first;
		char compColor;
		cout << "Enter time limit per move (in seconds): ";
		cin >> timel;
		cout << "Enter who makes first move (C or H): ";
		cin >> first;
		cout << "Enter what color player the computer is (W or B): ";
		cin >> compColor;
		GameController *game = new GameController(timel, first, compColor);
		string command = "";
		game->print();
		while (command != "q" && !game->isOver()) {
			cin >> command;
			if (game->move(command)) {
				game->print();
			}
			else {
				cout << "ILLEGAL MOVE!" << endl;
			}
		}
		delete game;
	}
	return 0;
}

