<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Repuestos e Insumos</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-md-3">
                                        <router-link
                                            v-if="
                                                permisos.includes(
                                                    'repuestos.create'
                                                )
                                            "
                                            :to="{
                                                name: 'repuestos.create',
                                            }"
                                            class="btn btn-primary btn-flat btn-block"
                                        >
                                            <i class="fa fa-plus"></i>
                                            Nuevo
                                        </router-link>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <b-col lg="10" class="my-1">
                                        <b-form-group
                                            label="Buscar"
                                            label-for="filter-input"
                                            label-cols-sm="3"
                                            label-align-sm="right"
                                            label-size="sm"
                                            class="mb-0"
                                        >
                                            <b-input-group size="sm">
                                                <b-form-input
                                                    id="filter-input"
                                                    v-model="filter"
                                                    type="search"
                                                    placeholder="Buscar"
                                                ></b-form-input>

                                                <b-input-group-append>
                                                    <b-button
                                                        class="bg-primary"
                                                        variant="primary"
                                                        :disabled="!filter"
                                                        @click="filter = ''"
                                                        >Borrar</b-button
                                                    >
                                                </b-input-group-append>
                                            </b-input-group>
                                        </b-form-group>
                                    </b-col>
                                    <div class="col-md-12">
                                        <b-overlay
                                            :show="showOverlay"
                                            rounded="sm"
                                        >
                                            <b-table
                                                :fields="fields"
                                                :items="listRegistros"
                                                show-empty
                                                stacked="md"
                                                responsive
                                                :current-page="currentPage"
                                                :per-page="perPage"
                                                @filtered="onFiltered"
                                                empty-text="Sin resultados"
                                                empty-filtered-text="Sin resultados"
                                                :filter="filter"
                                            >
                                                <template #cell(detalles)="row">
                                                    <b-button
                                                        size="sm"
                                                        variant="primary"
                                                        @click="
                                                            row.toggleDetails
                                                        "
                                                    >
                                                        {{
                                                            row.detailsShowing
                                                                ? "Ocultar"
                                                                : "Ver"
                                                        }}
                                                        Detalles
                                                    </b-button>
                                                </template>
                                                <template #row-details="row">
                                                    <b-card>
                                                        <h4 class="text-sm">
                                                            DATOS DE DEPENDENCIA
                                                        </h4>
                                                        <ul>
                                                            <li>
                                                                Equipo:
                                                                <span>{{
                                                                    row.item
                                                                        .detalle_equipo
                                                                }}</span>
                                                            </li>
                                                        </ul>
                                                        <h4 class="text-sm">
                                                            DATOS DE INVENTARIO
                                                        </h4>
                                                        <ul>
                                                            <li>
                                                                Precio:
                                                                <span>{{
                                                                    row.item
                                                                        .precio
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Stock Actual:
                                                                <span>{{
                                                                    row.item
                                                                        .stock_actual
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Stock Mínimo:
                                                                <span>{{
                                                                    row.item
                                                                        .stock_min
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Stock Máximo:
                                                                <span>{{
                                                                    row.item
                                                                        .stock_max
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Unidad de
                                                                medida:
                                                                <span>{{
                                                                    row.item
                                                                        .unidad_medida
                                                                }}</span>
                                                            </li>
                                                        </ul>
                                                        <h4 class="text-sm">
                                                            DATOS DE PROVEEDOR
                                                        </h4>
                                                        <ul>
                                                            <li>
                                                                Dirección:
                                                                <span>{{
                                                                    row.item.dir
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Teléfono:
                                                                <span>{{
                                                                    row.item
                                                                        .fono
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Correo
                                                                electrónico:
                                                                <span>{{
                                                                    row.item
                                                                        .correo
                                                                }}</span>
                                                            </li>
                                                        </ul>
                                                        <h4 class="text-sm">
                                                            DATOS DE UBICACIÓN
                                                        </h4>
                                                        <ul>
                                                            <li>
                                                                Almacén:
                                                                <span>{{
                                                                    row.item
                                                                        .almacen
                                                                }}</span>
                                                            </li>
                                                        </ul>
                                                        <h4 class="text-sm">
                                                            DATOS DE TERCEROS
                                                        </h4>
                                                        <ul>
                                                            <li>
                                                                Fabricante:
                                                                <span>{{
                                                                    row.item
                                                                        .fabricante
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Proveedor:
                                                                <span>{{
                                                                    row.item
                                                                        .proveedor
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Terciarios:
                                                                <span>{{
                                                                    row.item
                                                                        .terciarios
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Nombre Contacto:
                                                                <span>{{
                                                                    row.item
                                                                        .nombre_contacto
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Número de
                                                                teléfono:
                                                                <span>{{
                                                                    row.item
                                                                        .num_fono
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Correo
                                                                electrónico:
                                                                <span>{{
                                                                    row.item
                                                                        .correo_fabricante
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Dirección:
                                                                <span>{{
                                                                    row.item
                                                                        .dir_fabricante
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Número de
                                                                identificación:
                                                                <span>{{
                                                                    row.item
                                                                        .num_identificacion
                                                                }}</span>
                                                            </li>
                                                        </ul>
                                                    </b-card>
                                                    <b-button
                                                        size="sm"
                                                        variant="primary"
                                                        @click="
                                                            row.toggleDetails
                                                        "
                                                    >
                                                        Ocultar Detalles
                                                    </b-button>
                                                    <b-button
                                                        size="sm"
                                                        pill
                                                        variant="outline-warning"
                                                        class="btn-flat"
                                                        title="Editar registro"
                                                        @click="
                                                            editarRegistro(
                                                                row.item
                                                            )
                                                        "
                                                    >
                                                        <i
                                                            class="fa fa-edit"
                                                        ></i>
                                                    </b-button>
                                                    <b-button
                                                        size="sm"
                                                        pill
                                                        variant="outline-danger"
                                                        class="btn-flat"
                                                        title="Eliminar registro"
                                                        @click="
                                                            eliminaRepuesto(
                                                                row.item.id,
                                                                row.item
                                                                    .codigo +
                                                                    ' | ' +
                                                                    row.item
                                                                        .nombre +
                                                                    '<br>' +
                                                                    row.item
                                                                        .descripcion
                                                            )
                                                        "
                                                    >
                                                        <i
                                                            class="fa fa-trash"
                                                        ></i>
                                                    </b-button>
                                                </template>

                                                <template
                                                    #cell(fecha_registro)="row"
                                                >
                                                    {{
                                                        formatoFecha(
                                                            row.item
                                                                .fecha_registro
                                                        )
                                                    }}
                                                </template>

                                                <template #cell(accion)="row">
                                                    <div
                                                        class="row justify-content-between"
                                                    >
                                                        <b-button
                                                            size="sm"
                                                            pill
                                                            variant="outline-warning"
                                                            class="btn-flat btn-block"
                                                            title="Editar registro"
                                                            @click="
                                                                editarRegistro(
                                                                    row.item
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-edit"
                                                            ></i>
                                                        </b-button>
                                                        <b-button
                                                            size="sm"
                                                            pill
                                                            variant="outline-danger"
                                                            class="btn-flat btn-block"
                                                            title="Eliminar registro"
                                                            @click="
                                                                eliminaRepuesto(
                                                                    row.item.id,
                                                                    row.item
                                                                        .codigo +
                                                                        ' | ' +
                                                                        row.item
                                                                            .nombre +
                                                                        '<br>' +
                                                                        row.item
                                                                            .descripcion
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-trash"
                                                            ></i>
                                                        </b-button>
                                                    </div>
                                                </template>
                                            </b-table>
                                        </b-overlay>
                                        <div class="row">
                                            <b-col
                                                sm="6"
                                                md="2"
                                                class="ml-auto my-1"
                                            >
                                                <b-form-select
                                                    align="right"
                                                    id="per-page-select"
                                                    v-model="perPage"
                                                    :options="pageOptions"
                                                    size="sm"
                                                ></b-form-select>
                                            </b-col>
                                            <b-col
                                                sm="6"
                                                md="2"
                                                class="my-1 mr-auto"
                                                v-if="perPage"
                                            >
                                                <b-pagination
                                                    v-model="currentPage"
                                                    :total-rows="totalRows"
                                                    :per-page="perPage"
                                                    align="left"
                                                ></b-pagination>
                                            </b-col>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
export default {
    data() {
        return {
            permisos: localStorage.getItem("permisos"),
            search: "",
            listRegistros: [],
            showOverlay: false,
            fields: [
                { key: "codigo", label: "Código", sortable: true },
                { key: "codificacion", label: "Codificación", sortable: true },
                { key: "nombre", label: "Nombre", sortable: true },
                { key: "descripcion", label: "Descripción", sortable: true },
                { key: "marca", label: "Marca", sortable: true },
                { key: "modelo", label: "Modelo", sortable: true },
                { key: "serie", label: "Serie", sortable: true },
                { key: "stock_actual", label: "Stock Actual", sortable: true },
                { key: "detalles", label: "Detalles", sortable: true },
                { key: "accion", label: "Acción" },
            ],
            loading: true,
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            muestra_modal: false,
            modal_accion: "nuevo",
            currentPage: 1,
            perPage: 5,
            pageOptions: [
                { value: 5, text: "Mostrar 5 Registros" },
                { value: 10, text: "Mostrar 10 Registros" },
                { value: 25, text: "Mostrar 25 Registros" },
                { value: 50, text: "Mostrar 50 Registros" },
                { value: 100, text: "Mostrar 100 Registros" },
                { value: this.totalRows, text: "Mostrar Todo" },
            ],
            totalRows: 10,
            filter: null,
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getRepuestos();
    },
    methods: {
        // Seleccionar Opciones de Tabla
        editarRegistro(item) {
            this.$router.push({
                name: "repuestos.edit",
                params: {
                    id: item.id,
                },
            });
        },

        // Listar Repuestos
        getRepuestos() {
            this.showOverlay = true;
            this.muestra_modal = false;
            let url = "/admin/repuestos";
            if (this.pagina != 0) {
                url += "?page=" + this.pagina;
            }
            axios
                .get(url, {
                    params: { per_page: this.per_page },
                })
                .then((res) => {
                    this.showOverlay = false;
                    this.listRegistros = res.data.repuestos;
                    this.totalRows = res.data.total;
                });
        },
        eliminaRepuesto(id, descripcion) {
            console.log(descripcion);
            Swal.fire({
                title: "¿Quierés eliminar este registro?",
                html: `<strong>${descripcion}</strong><br><h4>Esto también eliminara los registros de entradas y no se podrá deshacer</h4>`,
                showCancelButton: true,
                confirmButtonColor: "#149FDA",
                confirmButtonText: "Si, eliminar",
                cancelButtonText: "No, cancelar",
                denyButtonText: `No, cancelar`,
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {
                    axios
                        .post("/admin/repuestos/" + id, {
                            _method: "DELETE",
                        })
                        .then((res) => {
                            this.getRepuestos();
                            this.filter = "";
                            Swal.fire({
                                icon: "success",
                                title: res.data.msj,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                        })
                        .catch((error) => {
                            if (error.response) {
                                if (error.response.status === 422) {
                                    this.errors = error.response.data.errors;
                                }
                                if (
                                    error.response.status === 420 ||
                                    error.response.status === 419 ||
                                    error.response.status === 401
                                ) {
                                    window.location = "/";
                                }
                                if (error.response.status === 500) {
                                    Swal.fire({
                                        icon: "error",
                                        title: "Error",
                                        html: error.response.data.message,
                                        showConfirmButton: false,
                                        timer: 2000,
                                    });
                                }
                            }
                        });
                }
            });
        },
        onFiltered(filteredItems) {
            // Trigger pagination to update the number of buttons/pages due to filtering
            this.totalRows = filteredItems.length;
            this.currentPage = 1;
        },
        formatoFecha(date) {
            if (date) {
                return this.$moment(String(date)).format("DD/MM/YYYY");
            }
            return "";
        },
    },
};
</script>

<style></style>
