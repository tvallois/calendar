//
//  Copyright (C) 2011-2012 Maxwell Barvian
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

namespace Maya.View {

    /**
     * Sidebar is a container for widgets that belong in the sidebar,
     * like the AgendaView
     */
    public class Sidebar : Gtk.Grid {

        public Gtk.EventBox label_box { get; private set; }
        public AgendaView agenda_view { get; private set; }

        public signal void event_removed (E.CalComponent event);
        public signal void event_modified (E.CalComponent event);

        public Sidebar () {


            label_box = new Gtk.EventBox ();

            /* label settings */
            Gtk.Label label = new Gtk.Label (_("Your upcoming events will be displayed here when you select a date with events."));
            label.sensitive = false;
            label.wrap = true;
            label.wrap_mode = Pango.WrapMode.WORD;
            label.margin_left = 12;
            label.margin_right = 12;
            label.justify = Gtk.Justification.CENTER;

            agenda_view = new AgendaView ();
            agenda_view.expand = true;

            label_box.add (label);

            attach (label_box, 0, 0, 1, 1);
            attach (agenda_view, 0, 1, 1, 1);

            agenda_view.hide ();

            label_box.set_vexpand(true);
            label_box.set_hexpand(true);
            set_vexpand(true);
            set_hexpand(true);

            label_box.show ();
            label.show ();
            agenda_view.shown_changed.connect (on_agenda_view_shown_changed);
            agenda_view.event_removed.connect ((event) => (event_removed (event)));
            agenda_view.event_modified.connect ((event) => (event_modified (event)));
        }

        public void set_selected_date (DateTime date) {
            agenda_view.set_selected_date (date);
        }

        void on_agenda_view_shown_changed (bool old_shown, bool shown) {
            if (shown) {
                agenda_view.show ();
                label_box.hide ();
            } else {
                agenda_view.hide ();
                label_box.show ();
            }
        }

        /**
         * Called when the user searches for the given text.
         */
        public void set_search_text (string text) {
            agenda_view.set_search_text (text);
        }

    }

}