import { Module } from '@nestjs/common';
import { DesksService } from './desks.service';
import { DesksController } from './desks.controller';
import { Desk } from './entities/desk.entity';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [TypeOrmModule.forFeature([Desk])],
  controllers: [DesksController],
  providers: [DesksService],
})
export class DesksModule {}
