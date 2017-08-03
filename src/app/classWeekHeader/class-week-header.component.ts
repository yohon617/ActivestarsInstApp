import { Component, OnInit } from '@angular/core';

import { Class } from './../models/class';
import { ClassService } from './../services/class/class.service';
import { ConfigService } from './../config/config.service';

@Component({
    selector: 'class-week-header',
    templateUrl: './class-week-header.component.html',
    styleUrls: ['./class-week-header.component.css']
})
export class ClassWeekHeaderComponent implements OnInit {

    testParam: string;

    constructor(private classService: ClassService, private config: ConfigService) { }

    ngOnInit(): void {
        
        //this.classService.postTest()
        //    .then(result => this.testParam = result);
    }

    prev() {
        console.log("prev");
        if (this.classService.SelectedClassWeek.WeekNumber > 1)
          this.classService.SelectedClassWeek = this.classService.SelectedClassWeeks[this.classService.SelectedClassWeek.WeekNumber - 2];
    }

    next() {
        console.log("next");
        if (this.classService.SelectedClassWeek.WeekNumber < this.classService.SelectedClassWeeks.length)
          this.classService.SelectedClassWeek = this.classService.SelectedClassWeeks[this.classService.SelectedClassWeek.WeekNumber];
        
    }
    
}
