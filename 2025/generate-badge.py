import subprocess
import os.path
import pathlib
import click

@click.command()
@click.option('--name', '-n', required=True, default="badge", type=str, prompt="Name of badge")
@click.option('--role', '-r', type=str, default="default", help="Badge role name")
@click.option('--output-dir', '-o', type=click.Path(file_okay=False, dir_okay=True, resolve_path=True), default='build/')
@click.option('--color-top', '-t', type=str, default='red', help="Color of the top of the pokeball on the badge")
@click.option('--color-bottom', '-b', type=str, default='white', help="Color of the bottom of the pokeball on the badge")
@click.option('--color-inset', '-i', type=str, default='black', help="Color of the inset of the pokeball on the badge")
@click.option('--color-button', '-B', type=str, default='black', help="Color of the button on the pokeball")
@click.option('--color-text', '-T', type=str, default='black', help="Color of the pokeball text on the badge")
@click.option('--color-badge', default="gray", help="Color of the badge")
@click.option('--ball-text', type=str, default='R', help="Text/letter on the pokeball")
@click.option('--ball-text-size', type=int, default=10, help="Size of the text/letter on the pokeball")
@click.option('--font-size', '-Fs', type=float)
@click.option('--omit-clip', is_flag=True, help="Omit the clip on the badge")
@click.argument('text-lines', nargs=-1, type=str)
def make_stls(name: str, role: str, output_dir: str, color_top: str, color_bottom: str, color_inset: str, color_button: str, color_text: str, color_badge: str, ball_text: str, ball_text_size: int, font_size: int, omit_clip: bool, text_lines):
     texts=','.join(f'"{line}"' for line in text_lines)

     # Make sure the directory exists.
     pathlib.Path(output_dir).mkdir(parents=True, exist_ok=True)

     for export_type in ('all', 'badge', 'text', 'top', 'bottom', 'inset', 'button', 'letter'):
          out_file = f'{name}-{role}-{export_type}'
          if export_type == 'all':
               out_file += '.png'
          else:
               out_file += '.stl'
          out_path = os.path.join(output_dir, out_file)
          cmd = [
               'openscad',
               '-D', f'TEXT=[{texts}]',
               '-D', f'BALL_COLOR_TOP="{color_top}"',
               '-D', f'BALL_COLOR_BOTTOM="{color_bottom}"',
               '-D', f'BALL_COLOR_INSET="{color_inset}"',
               '-D', f'BALL_COLOR_BUTTON="{color_button}"',
               '-D', f'BALL_COLOR_TEXT="{color_text}"',
               '-D', f'BALL_TEXT="{ball_text}"',
               '-D', f'BALL_TEXT_SIZE={ball_text_size}',
               '-D', f'BADGE_COLOR="{color_badge}"',
               '-D', f'EXPORT="{export_type}"',
          ]

          if omit_clip:
               cmd += [
                    '-D', 'OMIT_CLIP=true'
               ]

          if font_size:
               cmd += [
                    '-D', f'TXT_SIZE={font_size}'
               ]
          
          cmd += ['-o', out_path]

          cmd += [f'{name}.scad']

          print(' '.join(cmd))
          subprocess.run(cmd)

if __name__ == '__main__':
     make_stls()
