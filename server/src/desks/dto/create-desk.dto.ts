import { IsNotEmpty } from 'class-validator';

export class CreateDeskDto {
  @IsNotEmpty()
  name: string;

  @IsNotEmpty()
  room: string;
}
