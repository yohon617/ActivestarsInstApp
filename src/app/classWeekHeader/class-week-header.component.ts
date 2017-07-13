﻿import { Component, OnInit } from '@angular/core';

import { Class } from './../models/class';
import { ClassService } from './../services/class/class.service';

@Component({
    selector: 'class-week-header',
    templateUrl: './class-week-header.component.html',
    styleUrls: ['./class-week-header.component.css']
})
export class ClassWeekHeaderComponent implements OnInit {
    
    constructor(private classService: ClassService) { }

    ngOnInit(): void {

    }
    
}
